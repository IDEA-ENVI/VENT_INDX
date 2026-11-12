--{
create or replace procedure grid_aggreg (year in number)
as
begin
-- Procedura pocita agregovane udaje pro ventilacni index typu GRID
-- Vypocet probiha podle zadani ukolu c.1 za 4.q.2026
-- nov 2026-11-11
   declare
      w_start_time date;
      w_end_time date;
      w_count number(8,0);
      begin
         delete from vix.grid_c_data_record_tmp;
         insert into vix.grid_c_data_record_tmp (id_station, id_component, start_time, end_time)
         select distinct
         r.id_station,
         r.id_component,
         m.mesic /*+ 1/24*/                as start_time,
         add_months(m.mesic, 1) /*+ 1/24*/ as end_time
         from   vix.grid_c_data_record r
         cross apply (
         select add_months(trunc(r.start_time, 'MM'), level - 1) as mesic
         from   dual
         connect by level <= months_between(trunc(r.end_time - 1/86400, 'MM'),
                                          trunc(r.start_time, 'MM')) + 1
         ) m;      
         delete from vix.grid_c_data_record;
         insert into vix.grid_c_data_record (id_station, id_component, start_time, end_time) select id_station, id_component, start_time, end_time from vix.grid_c_data_record_tmp;
         grid_aggreg_pbl(1);   -- výpočet pbl
         commit;
         grid_aggreg_t(2);   -- výpočet teploty
         commit;         
         grid_aggreg_vix(3); -- výpočet ventilačního indexu
         commit;
         delete from vix.grid_c_data_record;
         delete from vix.grid_c_data_record_tmp;
         commit;
      end;

end grid_aggreg;
/
--}
grant execute on grid_aggreg to vix_rw_role;
create or replace public synonym grid_aggreg for grid_aggreg;
--select to_char(current_date,'yyyy-mm-dd hh24:mi:ss') from dual;
--execute vix_aggreg(1);
--select to_char(current_date,'yyyy-mm-dd hh24:mi:ss') from dual;
exit;