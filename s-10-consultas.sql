--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Consultas

--Mostrar el nombre completo, el correo electronico y el numero de pedidos de
--los clientes que han realizado mas de tres pedidos.

select c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno, c.email,
  count(*) as num_pedidos
from cliente c
join pedido p
on c.cliente_id=p.cliente_id
group by c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno, c.email
having count(*)>3;

--Mostrar los nombres de todos los empleados que son gerentes de alguna farmacia. Omitir
--aquellas farmacias que tambien funcionan como almacen

select e.nombre, e.apellido_paterno, e.apellido_materno
from empleado e
join farmacia f
on e.empleado_id=f.gerente_id
minus
select e.nombre, e.apellido_paterno, e.apellido_materno
from empleado e
join farmacia f
on e.empleado_id=f.gerente_id
natural join centro_operaciones co
on f.centro_operaciones_id=co.centro_operaciones_id
where es_almacen=1;

--Mostrar el nombre completo de todos los empleados responsables de algun pedido,
--la clave del status del pedido y la ubicacion del pedido, si es que cuenta con una.

select e.nombre, e.apellido_paterno, e.apellido_materno, sp.clave,
  u.latitud, u.longitud
from empleado e
join pedido p
on e.empleado_id=p.responsable_id
join status_pedido sp
on p.status_pedido_id=status_pedido_id
left join ubicacion u
on p.ubicacion_id=u.ubicacion_id


prompt Se conceden permisos al usuario invitado para leer una vista
grant select on v_gastos_cliente to ps_proy_invitado;

prompt Conectando con el usuario invitado
connect ps_proy_invitado

--Mostrar el nombre completo y correo electronico del cliente que mas 
--dinero ha gastado en medicamentos

select c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno, c.email
from v_gastos_cliente gc
join cliente c
on gc.cliente_id=c.cliente_id
where gc.gastos_totales=(
  select max(gastos_totales)
  from v_gastos_cliente
);