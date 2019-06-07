--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Valida existencia de medicamentos en almacenes

set serveroutput on


Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido
Prompt ========================================


insert into operacion_almacen (operacion_almacen_id, tipo_evento, almacen_id, 
  empleado_id) 
values (ope_almacen_seq.nextval, 'SALIDA', 100, 20);

insert into almacen_medicamento (almacen_medicamento_id, unidades_medicamento,
  operacion_almacen_id, medicamento_id) 
values (almacen_med_seq.nextval, 50, 51, 20);


Prompt OK, prueba 1 exitosa.


Prompt =======================================
Prompt Prueba 2.
prompt Intentando insertar registro no valido
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin

  insert into almacen_medicamento (almacen_medicamento_id, unidades_medicamento,
    operacion_almacen_id, medicamento_id) 
  values (almacen_med_seq.nextval, 60, 51, 20);
  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20001,
    ' ERROR: No deberia haber medicamentos suficientes.'||
    ' El trigger no está funcionando correctamente');
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20010 then
      dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;