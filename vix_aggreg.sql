set serveroutput on size 100000;
alter session set NLS_NUMERIC_CHARACTERS='. ';

create or replace procedure vix_aggreg (year in number)
as
begin
-- Procedura pocita agregovane udaje vintilacni index
-- Vypocet probiha podle zadani ukolu c.2 za 2.q.2021
-- 2022-02-02
-- nov
   declare
      w_start_time date;
      w_end_time date;
      
      w_id_value_type_data number(8,0);
      
      w_id_aggreg_type_avg_1d number(8,0);
      w_id_aggreg_type_avg_1m number(8,0);
      w_id_aggreg_type_avg_1y number(8,0);

      w_id_aggreg_type_ome_d1 number(8,0);
      w_id_aggreg_type_ome_d2 number(8,0);
      w_id_aggreg_type_ome_d3 number(8,0);


      w_min_values_1d number(6,0);
      w_min_values_1m number(6,0);
      w_min_values_1y number(6,0);

      w_value float;
      w_count number(8,0);

      w_count_1 number(8,0);
      w_count_2 number(8,0);
      w_count_3 number(8,0);

      w_running_time date;

      begin

         w_min_values_1d := 18;
         w_min_values_1m := 504;
         w_min_values_1y := 6570;

         select id into w_id_value_type_data
         from vix_c_value_type
         where fixed_id=1;

         select id into w_id_aggreg_type_avg_1d
         from vix_c_aggreg_type
         where fixed_id=1;

         select id into w_id_aggreg_type_avg_1m
         from vix_c_aggreg_type
         where fixed_id=2;

         select id into w_id_aggreg_type_avg_1y
         from vix_c_aggreg_type
         where fixed_id=3;

         select id into  w_id_aggreg_type_ome_d1
         from vix_c_aggreg_type
         where fixed_id=4;

         select id into  w_id_aggreg_type_ome_d2
         from vix_c_aggreg_type
         where fixed_id=5;

         select id into  w_id_aggreg_type_ome_d3
         from vix_c_aggreg_type
         where fixed_id=6;

         delete from vix_c_data_record;

         insert into vix_c_data_record (id,id_area,start_time,end_time)
         select vix_id_data_record.nextval,id_area,start_time,end_time from (
         select distinct id_area,trunc(start_time,'month') as start_time ,add_months(trunc(start_time,'month'),1) as end_time
         from vix_p_primary_data
         order by id_area,trunc(start_time,'month'));

         for rec_tab0 in (
            select id,id_area,start_time,end_time
            from vix_c_data_record
            order by id
            )
         loop
            delete from vix_s_secondary_data
            where id_area=rec_tab0.id_area
            and start_time>=rec_tab0.start_time
            and start_time< rec_tab0.end_time;
            commit;
         end loop;

         -- Cyklus pres nahrana primarni data z tabulky vix_p_primary_data
         for rec_tab1 in (
            select id,id_area,start_time,end_time
            from vix_c_data_record
            order by id
            )
         loop

            w_running_time := rec_tab1.start_time;
            w_end_time := rec_tab1.end_time;
            while (w_running_time < w_end_time) loop -- cyklus po hodine

               select avg(value),count(value) into w_value,w_count
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_running_time
               and start_time< w_running_time + 1
               and id_value_type=w_id_value_type_data
               and value is not null;

               if w_count > w_min_values_1d then
                  insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
                  values (rec_tab1.id_area,w_running_time,w_id_aggreg_type_avg_1d,w_value);
               end if;

               select count(value) into w_count_1
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_running_time
               and start_time< w_running_time + 1
               and id_value_type=w_id_value_type_data
               and value > 3000;

               select count(value) into w_count_2
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_running_time
               and start_time< w_running_time + 1
               and id_value_type=w_id_value_type_data
               and value > 1100 and value <= 3000;

               select count(value) into w_count_3
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_running_time
               and start_time< w_running_time + 1
               and id_value_type=w_id_value_type_data
               and value < 1100;

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab1.id_area,w_running_time,w_id_aggreg_type_ome_d1,100*w_count_1/w_count);

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab1.id_area,w_running_time,w_id_aggreg_type_ome_d2,100*w_count_2/w_count);

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab1.id_area,w_running_time,w_id_aggreg_type_ome_d3,100*w_count_3/w_count);


               w_running_time := w_running_time + 1; -- pricteni jednoho dne
            end loop;

            for rec_tab2 in (
               select avg(value) as value,count(*) as count
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=rec_tab1.start_time
               and start_time< rec_tab1.end_time
               and id_value_type=w_id_value_type_data
               and value is not null
               )
            loop

/*
               -- denni prumery
               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               select rec_tab1.id_area,to_date(to_char(start_time,'yyyy-mm-dd'),'yyyy-mm-dd'),w_id_aggreg_type_avg_1d,avg(value)
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=rec_tab1.start_time
               and start_time< rec_tab1.end_time
               and id_value_type=w_id_value_type_data
               and value is not null
               group by to_char(start_time,'yyyy-mm-dd')
               having count(*) > w_min_values_1d
               order by to_char(start_time,'yyyy-mm-dd');
               commit;
*/

               -- mesicni prumery
               if rec_tab2.count > w_min_values_1m then
                  insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
                  values (rec_tab1.id_area,rec_tab1.start_time,w_id_aggreg_type_avg_1m,rec_tab2.value);
               end if;
               commit;
            end loop;
         end loop;
         -- rocni prumery
         for rec_tab3 in (
            select distinct id,id_area,trunc(start_time,'year') as start_time,add_months(trunc(start_time,'year'),12) as end_time
            from vix_c_data_record
            order by id
            )
         loop
            delete from vix_s_secondary_data
            where id_area=rec_tab3.id_area
            and start_time=rec_tab3.start_time
            and id_aggreg_type=w_id_aggreg_type_avg_1y;
            commit;

            select avg(value),count(*) into w_value,w_count
            from vix_p_primary_data
            where id_area=rec_tab3.id_area
            and start_time>=rec_tab3.start_time
            and start_time< rec_tab3.end_time
            and id_value_type=w_id_value_type_data
            and value is not null;


            
--            if w_count > w_min_values_1y then

            insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
            values (rec_tab3.id_area,rec_tab3.start_time,w_id_aggreg_type_avg_1y,w_value);
            commit;

--            end if;
         end loop;

      end;
end vix_aggreg;
/
grant execute on vix_aggreg to vix_rw_role;

select to_char(current_date,'mi:ss') from dual;

execute vix_aggreg(1);

select to_char(current_date,'mi:ss') from dual;

exit;

w_id_aggreg_type_ome_d3