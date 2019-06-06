--@Autores: Miguel Ángel Pérez Quiroz, Sánchez Díaz María Beatriz
--@Fecha creación: 05/06/2019
--@Descripción: Creación de secuencias

--Sinonimos publicos
create or replace public synonym medicamento for ps_proy_admin.medicamento;
create or replace public synonym cliente for ps_proy_admin.cliente;
create or replace public synonym farmacia for ps_proy_admin.farmacia;

--Se otorgan permisos de lectura al usuario invitado
grant select on medicamento to ps_proy_invitado;
grant select on cliente to ps_proy_invitado;
grant select on farmacia to ps_proy_invitado;
grant select on oficina to ps_proy_invitado;
grant select on almacen to ps_proy_invitado;
grant select on pedido to ps_proy_invitado;

--Se otorgan permisos para crear sinonimos al usuario invitado
prompt Conectando con el usuario sys
connect sys as sysdba;
grant create synonym to ps_proy_invitado;

prompt Conectando con el usuario invitado
connect ps_proy_invitado;
create or replace synonym oficina for ps_proy_admin.medicamento;
create or replace synonym almacen for ps_proy_admin.medicamento;
create or replace synonym pedido for ps_proy_admin.medicamento;

prompt Conectando con el usuario administrador
connect ps_proy_admin
create or replace synonym ps_empleado for empleado;
create or replace synonym ps_nombre_medicamento for nombre_medicamento;
create or replace synonym ps_medicamento for medicamento;
create or replace synonym ps_presentacion_medicamento for presentacion_medicamento;
create or replace synonym ps_farmacia_medicamento for farmacia_medicamento;
create or replace synonym ps_centro_operaciones for centro_operaciones;
create or replace synonym ps_farmacia for farmacia;
create or replace synonym ps_oficina for oficina;
create or replace synonym ps_almacen for almacen;
create or replace synonym ps_operacion_almacen for operacion_almacen;
create or replace synonym ps_almacen_medicamento for almacen_medicamento;
create or replace synonym ps_tarjeta for tarjeta;
create or replace synonym ps_cliente for cliente;
create or replace synonym ps_pedido for pedido;
create or replace synonym ps_ubicacion for ubicacion;
create or replace synonym ps_status_pedido for status_pedido;
create or replace synonym ps_historico_status_pedido for historico_status_pedido;
create or replace synonym ps_detalle_pedido for detalle_pedido;