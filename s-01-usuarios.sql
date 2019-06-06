--@Autores: Miguel Ángel Pérez Quiroz, Sánchez Díaz María Beatriz
--@Fecha creación: 05/06/2019
--@Descripción: Creación de usuarios

prompt Ingresa la contraseña del usuario sys
connect sys as sysdba

prompt Se crea usuario ps_proy_invitado
create user ps_proy_invitado identified by pesa
quota 1000m on users;

prompt Se crea usuario ps_proy_admin
create user ps_proy_admin identified by pesa
quota 1000m on users;

prompt Se crea rol invitado
create role rol_invitado;
grant create session to rol_invitado;

prompt Se crea rol admin
create role rol_admin;
grant create session, create table, create view, create synonym,
    create public synonym, create sequence, create trigger, create procedure 
to rol_admin;

grant rol_admin to ps_proy_admin;
grant rol_invitado to ps_proy_invitado;

prompt Conectando con el usuario administrador
connect ps_proy_admin;