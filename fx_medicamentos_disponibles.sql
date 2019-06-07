--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Funcion para obtener existencias de un medicamento en almacen

create or replace function medicamentos_disponibles_fx(
  v_in_medicamento_id almacen_medicamento.medicamento_id%type,
  v_in_almacen_id operacion_almacen.almacen_id%type
) return number is

v_unidades_entrada number;
v_unidades_salida number;
v_medicamentos_disponibles number;

begin
  select nvl(sum(am.unidades_medicamento),0) into v_unidades_entrada
  from almacen_medicamento am
  join operacion_almacen oa
  on am.operacion_almacen_id=oa.operacion_almacen_id
  where oa.tipo_evento='ENTRADA'
  and am.medicamento_id=v_in_medicamento_id
  and oa.almacen_id=v_in_almacen_id;

  select nvl(sum(am.unidades_medicamento),0) into v_unidades_salida
  from almacen_medicamento am
  join operacion_almacen oa
  on am.operacion_almacen_id=oa.operacion_almacen_id
  where oa.tipo_evento='SALIDA'
  and am.medicamento_id=v_in_medicamento_id
  and oa.almacen_id=v_in_almacen_id;

  v_medicamentos_disponibles := v_unidades_entrada-v_unidades_salida;

  return v_medicamentos_disponibles;

end;
/
show errors