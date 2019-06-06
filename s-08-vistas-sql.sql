--@Autor(es):--Sánchez Díaz María Beatriz
			 --Pérez Quiroz Miguel Angel
--@Fecha creación: 02/06/2019
--@Descripción:Script 8- vistas


--VISTA PARA PEDIDO Y DETALLE DE PEDIDO



--generamos un reporte para mostrar por cada operacion realizada
--el número total de medicamentos así como el número de medicamentos de cada tipo 
create or replace view v_informacion_almacen_operaciones(
operacion_almacen_id, medicamento_id, unidades_medicamento, unidadaes_totales,
tipo_evento, fecha_evento
) as select oa.operacion_almacen_id, am.medicamento_id, am.medicamento_id, am.unidades_medicamento,
			oa.tipo_evento, oa.fecha_evento
			from almacen_medicamento am
			join operacion_almacen 
			on am.operacion_almacen_id=oa.operacion_almacen_id;



create or replace view v_inventario_farmacias(
	centro_operaciones_id, medicamento_id, presentacion, cantidad, unidades_disponibles
)as select fm.centro_operaciones_id as farmacia_id, fm.medicamento_id, pm.presentacion, pm.cantidad
		fm.unidades_disponibles
		from farmacia_medicamento fm
		join presentacion_medicamento pm
		on fm.presentacion_medicamento_id=pm.presentacion_medicamento_id;


create or replace view v_pedido(

) as select p.pedido_id, p.fecha, p.folio, p.importe_total, sum(dp.unidades_medicamento) as total_articulos
	from pedido p
	join detalle_pedido dp 
	on p.pedido_id=dp.pedido_id
	group by(p.pedido_id);
