--{
create or replace procedure vix_aggreg (year in number)
as
begin
-- Procedura pocita agregovane udaje pro ventilacni index
-- Vypocet probiha podle zadani ukolu c.2 za 2.q.2021
-- nov 2026-05-13 - ukol c.8 za 2.q.2026 - Přepracování - výpočet za jednotlivé veličiny nyní probíhá zvlášť
   declare
      w_start_time date;
      w_end_time date;
      w_count number(8,0);
      begin
         -- Pri nahravani zatim nevytvarime data_record, tak si ho vytvorime zde z primarnich dat po mesicich.
         delete from vix.vix_c_data_record;

         insert into vix.vix_c_data_record (id,id_area,id_component,start_time,end_time)
         select vix.vix_id_data_record.nextval,id_area,id_component,start_time,end_time from (
         select distinct id_area,id_component,trunc(start_time,'month')+1/24 as start_time ,add_months(trunc(start_time,'month'),1)+1/24 as end_time
         from vix.vix_p_primary_data
         order by id_area,id_component,trunc(start_time,'month'));
         commit;
         select count(*) into w_count from vix.vix_c_data_record;
         vix_aggreg_vix(1); -- výpočet ventilačního index
         commit;
         vix_aggreg_t(2);   -- výpočet teploty
         commit;
      end;
end vix_aggreg;
/
--}
grant execute on vix_aggreg to vix_rw_role;
create or replace public synonym vix_aggreg for vix_aggreg;
--select to_char(current_date,'yyyy-mm-dd hh24:mi:ss') from dual;
--execute vix_aggreg(1);
--select to_char(current_date,'yyyy-mm-dd hh24:mi:ss') from dual;
exit;