--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Funcion para generar archivo en formato csv

create or replace function reporte_clientes_csv_fx(
  v_in_cliente_id cliente.cliente_id%type
) return varchar2 is

v_cliente_id varchar2(10);
v_num_pedidos varchar2(20);
v_gastos_totales varchar2(20);
v_medicamentos_comprados varchar2(10);
v_separador varchar2(1):=',';
v_resultado varchar2(100):='';

begin
  select to_char(cliente_id), to_char(num_pedidos), 
    to_char(gastos_totales), to_char(medicamentos_comprados)
    into v_cliente_id, v_num_pedidos, v_gastos_totales, v_medicamentos_comprados
  from v_gastos_cliente
  where cliente_id=v_in_cliente_id;

  if v_cliente_id is not null then
    v_resultado:=v_cliente_id
      || v_separador
      || v_num_pedidos
      || v_separador
      || v_gastos_totales
      || v_separador
      || v_medicamentos_comprados;
  end if;
  return v_resultado;
end;
/
show errors

prompt Se genera archivo txt con el resultado de la funcion
set pagesize 100
set linesize 300
set feedback off
set heading off

spool reporte_clientes_csv.txt
select reporte_clientes_csv_fx(1)
from dual;
spool off
set feedback on
set heading on