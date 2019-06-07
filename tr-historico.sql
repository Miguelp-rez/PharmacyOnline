--@Autor(es):--Sánchez Díaz María Beatriz
       --Pérez Quiroz Miguel Angel
--@Fecha creación: 06/06/2019
--@Descripción: Trigger auxiliar

create or replace trigger hist_status_trigger
after insert or update of status_pedido_id on pedido
for each row

declare
v_status_id number(10,0);
v_fecha_status date;
v_hist_id number(10,0);
v_pedido_id number(10,0);
begin
select hist_status_ped_seq.nextval into v_hist_id from dual;

v_status_id := :new.status_pedido_id;
v_fecha_status := :new.fecha_status;
v_pedido_id := :new.pedido_id;

insert into historico_status_pedido
(historico_status_pedido_id,status_pedido_id,fecha_status_pedido,pedido_id)
values(v_hist_id,v_status_id,v_fecha_status,v_pedido_id);
end;
/
show errors