

prompt Ingresa la contraseña del usuario sys
connect sys as sysdba

drop user ps_proy_admin cascade;
drop user ps_proy_invitado cascade;

drop role rol_admin;
drop role rol_invitado;


@@s-01-usuarios.sql
@@s-02-entidades.sql
@@s-03-tablas-temporales.sql
@@s-05-secuencias.sql
@@s-06-indices.sql
@@s-07-sinonimos.sql
@@s-08-vistas
@@tr-historico.sql
@@s-09-carga-inicial.sql
Prompt CONSULTAS
@@s-10-consultas.sql

--FUNCIONES
@@fx_folios.sql
@@fx_medicamentos_disponibles.sql
@@fx_reporte_clientes_csv.sql


--TRIGGERS
@@s-11-tr_existencia_articulos.sql
@@tr-existencia-medicamentos.sql
@@s-11-tr-empleados_prueba.sql

