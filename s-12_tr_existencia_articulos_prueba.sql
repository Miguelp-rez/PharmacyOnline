--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Valida existencia de medicamentos en farmacias

set serveroutput on


Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido
Prompt ========================================

--INICIALMENTE TIENE 137 
insert into detalle_pedido(detalle_pedido_id,pedido_id,unidades_medicamento,centro_operaciones_id,
  presentacion_medicamento_id,medicamento_id) 
values(detalle_pedido_seq.nextval,3,1,20,11,9);
-- MENOS 1 LO HAEC CORRECTAMENTE


--MENOS 130

select * from farmacia_medicamento
where farmacia_medicamento_id=46;

insert into detalle_pedido(detalle_pedido_id,pedido_id,unidades_medicamento,
  centro_operaciones_id,presentacion_medicamento_id,medicamento_id) 
values(detalle_pedido_seq.nextval,3,130,20,11,9);

select * from farmacia_medicamento
where farmacia_medicamento_id=46;
Prompt OK, prueba 1 exitosa.

Prompt =======================================
Prompt Prueba 2.
prompt Intentando insertar registro no valido
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin
--YA NO DEBERIA PERMITIR 
insert into detalle_pedido(detalle_pedido_id,pedido_id,unidades_medicamento,
  centro_operaciones_id,presentacion_medicamento_id,medicamento_id) 
values(detalle_pedido_seq.nextval,3,14,20,11,9);

  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20001,
    ' ERROR: No deberia dejar comprar ni actualizar'||
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