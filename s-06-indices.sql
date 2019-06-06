--@Autor(es):--Sánchez Díaz María Beatriz
			 --Pérez Quiroz Miguel Angel
--@Fecha creación: 02/06/2019
--@Descripción:Script 6- índices


prompt iniciando con usuario admin
connect ps_proy_admin 

create unique index centro_operaciones_clave_iux on centro_operaciones(clave);

create index farmacia_rfc_ix on farmacia(rfc);
--CON FUNCIONES
create index empleado_nombre_ix on empleado(lower(nombre));
create index nombre_med_nombre_ix on nombre_medicamento(lower(nombre));
create index cliente_nombre_ix on cliente(lower(nombre));
--COMPUESTO
create index empleado_rfc_fecha_ix on empleado(rfc, fecha_ingreso);
--FK
create index nombre_medicamento_med_id_ix on nombre_medicamento(medicamento_id);
create index farmacia_med_presentacion_med_id_ix on farmacia_medicamento(presentacion_medicamento_id);





