
--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 02/06/2019
--@Descripción:Funcion generadora de folios

create or replace function folios_fx(
    p_cliente_id number) return varchar2 is 

cursor cur_datos_cliente is
  select c.cliente_id, substr(c.nombre,0,3) nombre, substr(c.apellido_paterno,0,3) apellido_paterno, 
  substr(c.apellido_materno,0,3) apellido_materno,
  count(*) as num_pedidos
  from cliente c
  join pedido p
  on c.cliente_id=p.cliente_id
  where c.cliente_id=p_cliente_id
  group by c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno, c.email;

v_str varchar2(11):='';

  begin
  for cur in cur_datos_cliente loop
    v_str:= p_cliente_id || cur.nombre||cur.apellido_paterno||cur.apellido_materno;
  end loop;

  return v_str;
  end;
  /
  show errors


