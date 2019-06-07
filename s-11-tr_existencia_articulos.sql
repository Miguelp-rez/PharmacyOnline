--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción:TRIGGER- ACTUALIZA INVENTARIO/ VERIFICA QUE HAYAN SUFICIENTES MEDICAMENTOS PARA LA COMPRA


set serveroutput on
create or replace trigger tr_existencia_medicamentos
  before insert 
  or update of detalle_pedido_id
  on detalle_pedido
  for each row

declare
  v_unidades_disponibles farmacia_medicamento.unidades_disponibles%type;
  v_medicamento_id farmacia_medicamento.medicamento_id%type;
  v_centro_operaciones_id farmacia_medicamento.farmacia_id%type;
  v_presentacion_medicamento_id farmacia_medicamento.presentacion_medicamento_id%type;

begin
   v_medicamento_id:=:new.medicamento_id;
   v_centro_operaciones_id:=:new.centro_operaciones_id;
   v_presentacion_medicamento_id:=:new.presentacion_medicamento_id;

begin
    --VERIFICANDO NUMERO DE UNIDADES ACTUALES
   select unidades_disponibles into v_unidades_disponibles
   from farmacia_medicamento fm
   where farmacia_id= :new.centro_operaciones_id
   and medicamento_id=:new.medicamento_id
   and presentacion_medicamento_id=:new.presentacion_medicamento_id;
   exception when no_data_found then
   v_unidades_disponibles:=0;
end;
  --SI EL NUMERO DE UNIDADES ES MENOR A 20 YA NO DEJAR HACER LA INSERCIÓN
   if v_unidades_disponibles<=20 then
   raise_application_error(-20005,'Es necesario realizar un chequeo'
      ||chr(10) 
      || 'del inventario en la farmacia con id '
      ||v_centro_operaciones_id 
      ||chr(10) 
      ||'se estan quedando sin unidades disponibles del medicamento con id: '
      ||v_medicamento_id
      ||chr(10) 
      ||'en la presentacion con id ' 
      ||v_presentacion_medicamento_id
      ||' NO ES POSIBLE REALIZAR OPERACION');
   else 
     update farmacia_medicamento set 
     unidades_disponibles=unidades_disponibles-:new.unidades_medicamento
     where farmacia_id= :new.centro_operaciones_id
     and medicamento_id=:new.medicamento_id
     and presentacion_medicamento_id=:new.presentacion_medicamento_id;
    dbms_output.put_line('Actualizando inventario');
  end if;

end;
/
show errors