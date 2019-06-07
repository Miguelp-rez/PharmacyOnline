--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Manejo de datos blob


--Cargamos los archivos a la base de datos
--ANTES:Descomprimir el archivo documentos.zip en /tmp
set serveroutput on 
connect sys/system as sysdba 

Prompt Creando objeto directory
create or replace directory tmp_docs_dir as '/tmp/documentos';

Prompt Otorgando privilegios al admnistrador para acceder al directorio
grant read,write on directory tmp_docs_dir to ps_proy_admin;

connect ps_proy_admin/pesa;

create or replace procedure sp_carga_documentos is
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;
  v_nombre_archivo varchar2(20);
  v_contador number := 0;

  cursor cur_almacenes is 
    select centro_operaciones_id
    from almacen
    where documento is not null;

begin 
  for fila in cur_almacenes loop
    v_src_offset := 1;
    v_dest_offset := 1;
    v_contador := v_contador + 1;
    dbms_output.put_line('Cargando imagen para almacen: ' 
      ||fila.centro_operaciones_id);

    --Se lee archivo externo
    v_nombre_archivo := 'doc';
    v_nombre_archivo := v_nombre_archivo || v_contador || '.xlsx';
    v_bfile := bfilename('TMP_DOCS_DIR', v_nombre_archivo);
    
    if dbms_lob.fileexists(v_bfile) = 1 and not 
      dbms_lob.isopen(v_bfile) = 1 then
        dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
    else 
      raise_application_error(-20001, 'El archivo no existe o esta abierto');
    end if;

    -- Inicializando el dato blob
    select documento into v_dest_blob
    from almacen
    where centro_operaciones_id=fila.centro_operaciones_id
    for update;

    -- Escribiendo el contenido del documento al dato BLOB
    dbms_lob.loadblobfromfile(
      dest_lob   => v_dest_blob, 
      src_bfile   => v_bfile,
      amount      => dbms_lob.getlength(v_bfile),
      dest_offset => v_dest_offset,
      src_offset  => v_src_offset);

    -- Cerrando recursos
    dbms_lob.close(v_bfile);

    -- Validando longitudes
    v_src_length := dbms_lob.getlength(v_bfile);
    v_dest_length := dbms_lob.getlength(v_dest_blob);
    if v_src_length != v_dest_length then
      raise_application_error(-20002, 'Longitudes incorrectas');
    end if;

  end loop;
end;
/
show errors
--Prompt Invocando procedimiento 
--exec sp_carga_documentos
--commit;
