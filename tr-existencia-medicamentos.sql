--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Valida existencia de medicamentos en almacenes

set serveroutput on

create or replace trigger tr_existencia_medicamentos
  for insert or update of unidades_medicamento on almacen_medicamento
  compound trigger

  --sección común
  v_operacion_almacen number;
  v_medicamento_id number;
  v_unidades_medicamento number;
  v_almacen_id number;
  v_tipo_evento varchar2(10);

  ------bloque before --------------
  before each row is
  begin
    v_unidades_medicamento := :new.unidades_medicamento;
    v_operacion_almacen := :new.operacion_almacen_id;
    v_medicamento_id := :new.medicamento_id;

    select oa.tipo_evento, oa.almacen_id into v_tipo_evento, v_almacen_id
    from operacion_almacen oa
    where oa.operacion_almacen_id=:new.operacion_almacen_id;

  end before each row;

  ----- bloque after statement
  after statement is
  v_unidades_entrada number;
  v_unidades_salida number;

  begin
    if v_tipo_evento='SALIDA' then
      select sum(am.unidades_medicamento) into v_unidades_entrada
      from almacen_medicamento am
      join operacion_almacen oa
      on am.operacion_almacen_id=oa.operacion_almacen_id
      where oa.tipo_evento='ENTRADA'
      and am.medicamento_id=v_medicamento_id
      and oa.almacen_id=v_almacen_id;

      select sum(am.unidades_medicamento) into v_unidades_salida
      from almacen_medicamento am
      join operacion_almacen oa
      on am.operacion_almacen_id=oa.operacion_almacen_id
      where oa.tipo_evento='SALIDA'
      and am.medicamento_id=v_medicamento_id
      and oa.almacen_id=v_almacen_id;

      if v_unidades_entrada-v_unidades_salida >= v_unidades_medicamento then
        dbms_output.put_line('OK');
      else
        raise_application_error(-20010,'No hay suficientes medicamentos');
      end if;
    end if;
  end after statement;
end;
/
show errors