--@Autores: Miguel Ángel Pérez Quiroz, Sánchez Díaz María Beatriz
--@Fecha creación: 05/06/2019
--@Descripción: Creación de usuarios

prompt Ingresa la contraseña del usuario sys
connect sys as sysdba

prompt Se crea usuario ps_proy_invitado
create user ps_proy_invitado identified by pesa

prompt Se crea usuario ps_proy_admin
create user ps_proy_admin identified by pesa

prompt Se crea rol invitado
create role rol_invitado;
grant create session to rol_invitado;

prompt Se crea rol admin
create role rol_admin;
grant create session, create table, create view, create synonym,
create sequence, create trigger, create procedure to rol_admin;
