declare
begin

prompt Realizando reporte 
p_pedidos(1,1,2,30,1,10)
commit;
---commit al final de las operaciones, todo se ejecutó correctamente.
commit;
exception
when others then
--algo salio mal, se aplica rollback
rollback;
end;
/