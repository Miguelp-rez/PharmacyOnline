--@Autor(es):--Sánchez Díaz María Beatriz
			 --Pérez Quiroz Miguel Angel
--@Fecha creación: 03/06/2019
--@Descripción:Script 3- tablas temporales

--

prompt Conectando como sys
connect sys as sysdba
-- objeto que apunta al directorio /tmp/bases del servidor
prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';
--se otorgan permisos para que el usuario jorge_0307 de la BD pueda leer
--el contenido del directorio
grant read, write on directory tmp_dir to ps_proy_admin;
prompt Contectando con usuario ps_proy_admin para crear la tabla externa
connect ps_proy_admin
show user
prompt creando tabla externa


create table cliente_ext(
	CLIENTE_ID          NUMBER(10, 0),
    NOMBRE              VARCHAR2(40),
    APELLIDO_PATERNO    VARCHAR2(40),
    APELLIDO_MATERNO    VARCHAR2(40),
    NUM_TELEFONICO      NUMBER(12,0),
    EMAIL               VARCHAR2(100),
    RFC                 VARCHAR2(12),
    CURP                VARCHAR2(16),
    DIRECCION			VARCHAR2(400)
)

organization external(
    type oracle_loader
    default directory tmp_dir
    access parameters (
        records delimited by newline
        badfile tmp_dir:'cliente_ext_bad.log'
        logfile tmp_dir:'cliente_ext.log'
        fields terminated by '#'
        lrtrim
        missing field values are null
        (
        cliente_id,nombre,apellido_paterno, apellido_materno,
        num_telefonico, email, rfc, curp, direccion
        )
    )
    location ('cliente_ext.txt')
)
reject limit unlimited;
--Creanto tmp/bases
prompt creando el directorio /tmp/bases en caso de no existir
!mkdir -p /tmp/bases
prompt cambiando permisos
!chmod 777 /tmp/bases

--archivo txt debe estar dentro de donde se ejecute el script
prompt copiando el archivo txt a /tmp/bases
!cp cliente_ext.txt /tmp/bases

--MOSTRANDO DATOS
prompt mostrando los datos
select * from cliente_ext;