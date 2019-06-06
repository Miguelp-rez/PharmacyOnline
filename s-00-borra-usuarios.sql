--@Autores: Miguel Ángel Pérez Quiroz, Sánchez Díaz María Beatriz
--@Fecha creación: 05/06/2019
--@Descripción: Creación de usuarios

prompt Ingresa la contraseña del usuario sys
connect sys as sysdba

drop user ps_proy_admin cascade;
drop user ps_proy_invitado cascade;

drop role rol_admin;
drop role rol_invitado;