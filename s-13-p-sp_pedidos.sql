--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 02/06/2019
--@Descripción:Procedimiento_reporte de compra


create or replace procedure sp_pedidos(
p_cliente_id in number,
p_responsable_id in number,
p_unidades_medicamento in number,
p_centro_operaciones in number,
p_presentacion_medicamento_id in number,
p_medicamento_id in number
) is

v_pedido_id number(10,0);
v_detalle_pedido_id number(10,0);
v_importe_total number(10,5);
v_folio varchar2(13):='';
v_cliente_id number(10,0);

cursor cur_clientes is
  select c.nombre nombre, c.apellido_paterno apellido_paterno,
  sum(dp.unidades_medicamento) total_medicamentos
  from pedido p
  join detalle_pedido dp 
  on p.pedido_id=dp.pedido_id
  join cliente c
  on c.cliente_id=p.CLIENTE_ID
  where c.cliente_id=p_cliente_id
  group by c.nombre, c.apellido_paterno;

v_str2 varchar2(500):='';

begin
select pedido_seq.nextval into v_pedido_id from dual;
select detalle_pedido_seq.nextval into v_detalle_pedido_id from dual;
select folios_fx(p_cliente_id) into v_folio from dual;
SELECT dbms_random.value(100, 2000) into v_importe_total FROM dual;


  execute immediate 'insert into pedido(
  pedido_id, fecha_status, folio, importe_total, status_pedido_id,
  ubicacion_id, cliente_id, responsable_id)
  values( :ph1, :ph2, :ph3, :ph4, :ph5, :ph6, :ph7, :ph8)' 
  using v_pedido_id, sysdate, v_folio, v_importe_total||v_pedido_id, 1, 2,p_cliente_id, p_responsable_id;


  execute immediate 'insert into detalle_pedido(
  detalle_pedido_id, pedido_id, centro_operaciones_id, presentacion_medicamento_id, 
  unidades_medicamento, medicamento_id)
  values( :ph1, :ph2, :ph3, :ph4, :ph5, :ph6)' 
  using v_detalle_pedido_id, v_pedido_id, p_centro_operaciones, p_presentacion_medicamento_id, p_unidades_medicamento,p_medicamento_id;

for cur in cur_clientes loop
v_str2:=  '----------GRACIAS POR TU COMPRA--------'
            ||chr(10) 
            ||cur.nombre||' '|| cur.apellido_paterno
            ||chr(10) 
            ||'importe_total: '
            || v_importe_total
            ||'Numero de medicamentos en esta compra: '
            ||p_unidades_medicamento
            ||chr(10) 
            ||'Medicamentos comprados hasta el momento:'  
            || cur.total_medicamentos;
end loop;

dbms_output.put_line(v_str2);

end;
/
show errors


prompt Invocando procedimiento sp_pedidos

exec sp_pedidos(1,1,2,30,1,10)
commit;


