--@Autor(es):--Sánchez Díaz María Beatriz
			 --Pérez Quiroz Miguel Angel
--@Fecha creación: 02/06/2019
--@Descripción:Script 8- vistas


--VISTA PARA PEDIDO Y DETALLE DE PEDIDO



--generamos un reporte para mostrar por cada operacion realizada
--el número total de medicamentos así como el número de medicamentos de cada tipo 
create or replace view v_reporte_almacen(
	operacion_almacen_id, tipo_evento, fecha_evento, medicamento_id, unidades_medicamento, 
	unidades_totales
) as select oa.operacion_almacen_id, oa.tipo_evento, oa.fecha_evento, am.medicamento_id, 
			am.unidades_medicamento, q1.unidades_totales
			from (
				select almacen_medicamento_id, sum(unidades_medicamento) as unidades_totales
				from almacen_medicamento
				group by almacen_medicamento_id
				) q1
			join almacen_medicamento am
			on q1.almacen_medicamento_id=am.almacen_medicamento_id
			join operacion_almacen oa
			on am.operacion_almacen_id=oa.operacion_almacen_id;

--generamos un reporte con el numero de pedidos que ha hecho un cliente, gastos totales,
-- y numero de medicamentos comprados
create or replace view v_gastos_cliente(
	cliente_id, num_pedidos, gastos_totales, medicamentos_comprados
)as select p.cliente_id, count(*) as num_pedidos, sum(importe_total) as importe_total,
			sum(unidades_medicamento)
		from pedido p
		join detalle_pedido dp
		on p.pedido_id=dp.pedido_id
		group by p.cliente_id;

--generamos un reporte de cuantos medicamentos se compraron en cada pedido
create or replace view v_pedido(
	pedido_id, fecha, folio, importe_total, total_articulos
) as select p.pedido_id, p.fecha_status, p.folio, p.importe_total, sum(dp.unidades_medicamento) as total_articulos
		from pedido p
		join detalle_pedido dp 
		on p.pedido_id=dp.pedido_id
		group by p.pedido_id, p.fecha_status, p.folio, p.importe_total;
