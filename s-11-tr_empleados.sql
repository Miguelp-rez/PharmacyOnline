--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 02/06/2019
--@Descripción:TR_ VALIDA EMPLEADOS


set serveroutput on
create or replace trigger tr_valida_empleado
  before insert
  on empleado
  for each row
declare
  v_edad number(10,0);
  v_empleado_gerente number(10,0);

begin
  select to_number(to_char(sysdate,'yyyy') ) into v_edad from dual;
    v_edad:=v_edad-to_number('19'||substr(:new.rfc,4,2));
      if v_edad<30 then
       raise_application_error(-20011,'La edad de nuestros empleados debe de ser mayor o igual a 30 años');
      else
        dbms_output.put_line('NUEVO EMPLEADO');
      end if;
end;
/
show errors