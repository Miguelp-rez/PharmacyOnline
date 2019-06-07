
Prompt =======================================
Prompt Prueba 3.
prompt Insertando un registro valido
Prompt ========================================


select * from empleado;
--EMPLEADO gerente
insert into empleado values(empleado_seq.nextval,'Beatriz','SAD70112324',
  'Sanchez','Diaz',to_date('07/06/2019','dd/mm/yyyy'));


select * from empleado;

Prompt OK, prueba 1 exitosa.

Prompt =======================================
Prompt Prueba 4.
prompt Intentando insertar registro no valido
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin
--tiene menos de 30
insert into empleado values(empleado_seq.nextval,'Beatriz','SAD90112324',
  'Sanchez','Diaz',to_date('07/06/2019','dd/mm/yyyy'));

  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20012,
    ' ERROR: No deberia dejar insertar'||
    ' El trigger no está funcionando correctamente');
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20005 then
      dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;