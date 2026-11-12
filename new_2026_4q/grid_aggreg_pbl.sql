--{
create or replace procedure grid_aggreg_pbl (in_id_component in number)
as
begin
-- Procedura pocita agregovane udaje pro velicinu PBL typu GRID
-- Vypocet probiha podle zadani ukolu c.1 za 4.q.2026
-- nov 2026-11-11
   declare
      w_start_time date;
      w_end_time date;
      
      w_id_component number(8,0);      

      w_id_value_type_data number(8,0);
      
      w_id_aggreg_type_avg_1d_pbl number(8,0);
      w_id_aggreg_type_avg_1m_pbl number(8,0);
      w_id_aggreg_type_avg_1y_pbl number(8,0);

      w_id_aggreg_type_med_1d_pbl number(8,0);
      w_id_aggreg_type_med_1m_pbl number(8,0);
      w_id_aggreg_type_med_1y_pbl number(8,0);

      w_min_values_1d number(6,0);
      w_min_values_1m number(6,0);
      w_min_values_1y number(6,0);

      w_value float;
      w_median float;      
      w_count number(8,0);

      w_running_time date;

      begin
         w_id_component := in_id_component;
         w_min_values_1d := get_min_values(to_date('2020-01-01','yyyy-mm-dd'),'DD');

         select id into w_id_value_type_data     from grid_c_value_type      where fixed_id=1;

         select id into w_id_aggreg_type_avg_1d_pbl  from vix.grid_c_aggreg_type where fixed_id=19;
         select id into w_id_aggreg_type_avg_1m_pbl  from vix.grid_c_aggreg_type where fixed_id=20;
         select id into w_id_aggreg_type_avg_1y_pbl  from vix.grid_c_aggreg_type where fixed_id=21;

         select id into w_id_aggreg_type_med_1d_pbl  from vix.grid_c_aggreg_type where fixed_id=22;
         select id into w_id_aggreg_type_med_1m_pbl  from vix.grid_c_aggreg_type where fixed_id=23;
         select id into w_id_aggreg_type_med_1y_pbl  from vix.grid_c_aggreg_type where fixed_id=24;

         for rec_tab0 in (
            select distinct id_station,id_component,start_time,end_time
            from vix.grid_c_data_record
            where id_component = w_id_component            
            order by id_station,id_component,start_time,end_time
            )
         loop
            delete from vix.grid_s_secondary_data
            where id_station=rec_tab0.id_station
            and id_component=rec_tab0.id_component
            and start_time>=rec_tab0.start_time
            and start_time< rec_tab0.end_time;
            commit;
         end loop;
         -- Cyklus pres vix.grid_c_data_record
         for rec_tab1 in (
            select distinct id_station,id_component,start_time,end_time
            from vix.grid_c_data_record
            where id_component = w_id_component                        
            order by id_station,id_component,start_time,end_time
            )
         loop
            w_running_time := rec_tab1.start_time;
            w_start_time := rec_tab1.start_time;
            w_end_time := rec_tab1.end_time;
            while (w_running_time < w_end_time) loop -- cyklus po hodine
               -- denni prumery
               select avg(value),count(value) into w_value,w_count
               from vix.grid_p_primary_data
               where id_station=rec_tab1.id_station
               and id_component=rec_tab1.id_component
               and start_time>=w_running_time
               and start_time< w_running_time + 1
               and id_value_type=w_id_value_type_data
               and value is not null;
               if w_count >= w_min_values_1d then
                  insert into vix.grid_s_secondary_data (id_station,id_component,start_time,id_aggreg_type,value)
                  values (rec_tab1.id_station,rec_tab1.id_component,w_running_time,w_id_aggreg_type_avg_1d_pbl,w_value);
                  commit;
               end if;
               -- denni median
               select median(value),count(value) into w_value,w_count
               from vix.grid_p_primary_data
               where id_station=rec_tab1.id_station
               and id_component=rec_tab1.id_component
               and start_time>=w_running_time
               and start_time< w_running_time + 1
               and id_value_type=w_id_value_type_data
               and value is not null;
               if w_count >= w_min_values_1d then
                  insert into vix.grid_s_secondary_data (id_station,id_component,start_time,id_aggreg_type,value)
                  values (rec_tab1.id_station,rec_tab1.id_component,w_running_time,w_id_aggreg_type_med_1d_pbl,w_value);
                  commit;
               end if;
               w_running_time := w_running_time + 1; -- pricteni jednoho dne
            end loop;
            for rec_tab2 in (
               -- mesicni prumery a mesicni median
               select avg(value) as value,median(value) as median,count(*) as count
               from vix.grid_p_primary_data
               where id_station=rec_tab1.id_station
               and id_component=rec_tab1.id_component
               and start_time>=rec_tab1.start_time
               and start_time< rec_tab1.end_time
               and id_value_type=w_id_value_type_data
               and value is not null
               )
            loop
               w_min_values_1m := get_min_values(rec_tab1.start_time,'MM');
               w_count := rec_tab2.count;
               -- mesicni prumery a mesicni median
               if w_count >= w_min_values_1m then
                  insert into vix.grid_s_secondary_data (id_station,id_component,start_time,id_aggreg_type,value)
                  values (rec_tab1.id_station,rec_tab1.id_component,rec_tab1.start_time,w_id_aggreg_type_avg_1m_pbl,rec_tab2.value);

                  insert into vix.grid_s_secondary_data (id_station,id_component,start_time,id_aggreg_type,value)
                  values (rec_tab1.id_station,rec_tab1.id_component,rec_tab1.start_time,w_id_aggreg_type_med_1m_pbl,rec_tab2.median);
               end if;
               commit;
            end loop;
         end loop;

         -- rocni prumery a median
         for rec_tab3 in (
            select distinct id_station,id_component,trunc(start_time,'year')+1/24 as start_time,add_months(trunc(start_time,'year'),12)+1/24 as end_time
            from vix.grid_c_data_record
            where id_component = w_id_component            
            order by id_station
            )
         loop
            w_start_time := rec_tab3.start_time;
            w_end_time   := rec_tab3.end_time;
            w_min_values_1y := get_min_values(w_start_time,'YYYY');            
            select avg(value), median(value) as median, count(*) into w_value, w_median, w_count
            from vix.grid_p_primary_data
            where id_station=rec_tab3.id_station
            and id_component=rec_tab3.id_component
            and start_time>=rec_tab3.start_time
            and start_time< rec_tab3.end_time
            and id_value_type=w_id_value_type_data
            and value is not null;
            if w_count >= w_min_values_1y then
               insert into vix.grid_s_secondary_data (id_station,id_component,start_time,id_aggreg_type,value)
               values (rec_tab3.id_station,rec_tab3.id_component,rec_tab3.start_time,w_id_aggreg_type_avg_1y_pbl,w_value);

               insert into vix.grid_s_secondary_data (id_station,id_component,start_time,id_aggreg_type,value)
               values (rec_tab3.id_station,rec_tab3.id_component,rec_tab3.start_time,w_id_aggreg_type_med_1y_pbl,w_median);
               commit;
            end if;
            commit;
         end loop;
--         delete from vix.grid_c_data_record where id_component = w_id_component;
      end;
end grid_aggreg_pbl;
/
--}
grant execute on grid_aggreg_pbl to grid_rw_role;
create or replace public synonym grid_aggreg_pbl for grid_aggreg_pbl;
exit;