set serveroutput on size 100000;
alter session set NLS_NUMERIC_CHARACTERS='. ';

create or replace procedure vix_aggreg (year in number)
as
begin
-- Procedura pocita agregovane udaje pro ventilacni index
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

      w_id_aggreg_type_ome_m1 number(8,0);
      w_id_aggreg_type_ome_m2 number(8,0);
      w_id_aggreg_type_ome_m3 number(8,0);

      w_id_aggreg_type_ome_y1 number(8,0);
      w_id_aggreg_type_ome_y2 number(8,0);
      w_id_aggreg_type_ome_y3 number(8,0);

      w_id_aggreg_type_cpp number(8,0);
      w_id_aggreg_type_cpp_value number(8,0);

      w_min_values_1d number(6,0);
      w_min_values_1m number(6,0);
      w_min_values_1y number(6,0);

      w_value float;
      w_count number(8,0);

      w_count_1 number(8,0);
      w_count_2 number(8,0);
      w_count_3 number(8,0);
      w_count_4 number(8,0);

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

         select id into  w_id_aggreg_type_ome_m1
         from vix_c_aggreg_type
         where fixed_id=7;

         select id into  w_id_aggreg_type_ome_m2
         from vix_c_aggreg_type
         where fixed_id=8;

         select id into  w_id_aggreg_type_ome_m3
         from vix_c_aggreg_type
         where fixed_id=9;

         select id into  w_id_aggreg_type_ome_y1
         from vix_c_aggreg_type
         where fixed_id=10;

         select id into  w_id_aggreg_type_ome_y2
         from vix_c_aggreg_type
         where fixed_id=11;

         select id into  w_id_aggreg_type_ome_y3
         from vix_c_aggreg_type
         where fixed_id=12;

         select id into  w_id_aggreg_type_cpp
         from vix_c_aggreg_type
         where fixed_id=13;

         -- Pri nahravani zatim nevytvarime data_record, tak si ho vytvorime zde z primarnich dat po mesicich.
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

         -- Cyklus pres vix_c_data_record
         for rec_tab1 in (
            select id,id_area,start_time,end_time
            from vix_c_data_record
            order by id
            )
         loop

            w_running_time := rec_tab1.start_time;
            w_start_time := rec_tab1.start_time;
            w_end_time := rec_tab1.end_time;
            while (w_running_time < w_end_time) loop -- cyklus po hodine
               -- denni prumery
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
               -- rozdeleni cetnosti podle OME - denni
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
               commit;
               -- rozdeleni cetnosti podle CPP/RPP - denni
               select count(value) into w_count_1
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_running_time
               and start_time< w_running_time + 1
               and id_value_type=w_id_value_type_data
               and value > 3000;

               if w_count_1 = 24 then
                  w_id_aggreg_type_cpp_value := 1;
               elsif w_count_1 >= 1 and w_count_1 <= 23  then
                  w_id_aggreg_type_cpp_value := 2;
               else
                  select count(value) into w_count_2
                  from vix_p_primary_data
                  where id_area=rec_tab1.id_area
                  and start_time>=w_running_time
                  and start_time< w_running_time + 1
                  and id_value_type=w_id_value_type_data
                  and value <= 3000;

                  select count(value) into w_count_3
                  from vix_p_primary_data
                  where id_area=rec_tab1.id_area
                  and start_time>=w_running_time
                  and start_time< w_running_time + 1
                  and id_value_type=w_id_value_type_data
                  and value <= 1100;
                  if w_count_2 = 24 and w_count_3 <= 17 then
                     w_id_aggreg_type_cpp_value := 3;
                  else
                     w_id_aggreg_type_cpp_value := 4;
                  end if;
               end if;
               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab1.id_area,w_running_time,w_id_aggreg_type_cpp,w_id_aggreg_type_cpp_value);
               commit;

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
               w_count := rec_tab2.count;
               -- mesicni prumery
               if w_count > w_min_values_1m then
                  insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
                  values (rec_tab1.id_area,rec_tab1.start_time,w_id_aggreg_type_avg_1m,rec_tab2.value);
               end if;
               commit;
               -- rozdeleni cetnosti podle OME - mesicni
               select count(value) into w_count_1
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_start_time
               and start_time< w_end_time
               and id_value_type=w_id_value_type_data
               and value > 3000;

               select count(value) into w_count_2
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_start_time
               and start_time< w_end_time
               and id_value_type=w_id_value_type_data
               and value > 1100 and value <= 3000;

               select count(value) into w_count_3
               from vix_p_primary_data
               where id_area=rec_tab1.id_area
               and start_time>=w_start_time
               and start_time< w_end_time
               and id_value_type=w_id_value_type_data
               and value < 1100;

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab1.id_area,rec_tab1.start_time,w_id_aggreg_type_ome_m1,100*w_count_1/w_count);

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab1.id_area,rec_tab1.start_time,w_id_aggreg_type_ome_m2,100*w_count_2/w_count);

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab1.id_area,rec_tab1.start_time,w_id_aggreg_type_ome_m3,100*w_count_3/w_count);
               commit;

            end loop;
         end loop;


         -- rocni prumery
         for rec_tab3 in (
            select distinct id_area,trunc(start_time,'year') as start_time,add_months(trunc(start_time,'year'),12) as end_time
            from vix_c_data_record
            order by id_area
            )
         loop
            w_start_time := rec_tab3.start_time;
            w_end_time   := rec_tab3.end_time;
            select avg(value),count(*) into w_value,w_count
            from vix_p_primary_data
            where id_area=rec_tab3.id_area
            and start_time>=rec_tab3.start_time
            and start_time< rec_tab3.end_time
            and id_value_type=w_id_value_type_data
            and value is not null;
            if w_count > w_min_values_1y then
               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab3.id_area,rec_tab3.start_time,w_id_aggreg_type_avg_1y,w_value);
               commit;
            end if;
               -- rozdeleni cetnosti podle OME - rocni
               select count(value) into w_count_1
               from vix_p_primary_data
               where id_area=rec_tab3.id_area
               and start_time>=w_start_time
               and start_time< w_end_time
               and id_value_type=w_id_value_type_data
               and value > 3000;

               select count(value) into w_count_2
               from vix_p_primary_data
               where id_area=rec_tab3.id_area
               and start_time>=w_start_time
               and start_time< w_end_time
               and id_value_type=w_id_value_type_data
               and value > 1100 and value <= 3000;

               select count(value) into w_count_3
               from vix_p_primary_data
               where id_area=rec_tab3.id_area
               and start_time>=w_start_time
               and start_time< w_end_time
               and id_value_type=w_id_value_type_data
               and value < 1100;

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab3.id_area,rec_tab3.start_time,w_id_aggreg_type_ome_y1,100*w_count_1/w_count);

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab3.id_area,rec_tab3.start_time,w_id_aggreg_type_ome_y2,100*w_count_2/w_count);

               insert into vix_s_secondary_data (id_area,start_time,id_aggreg_type,value)
               values (rec_tab3.id_area,rec_tab3.start_time,w_id_aggreg_type_ome_y3,100*w_count_3/w_count);
               commit;
         end loop;

         delete from vix_c_data_record;
      end;
end vix_aggreg;
/
grant execute on vix_aggreg to vix_rw_role;

select to_char(current_date,'yyyy-mm-dd hh24:mi:ss') from dual;

execute vix_aggreg(1);

select to_char(current_date,'yyyy-mm-dd hh24:mi:ss') from dual;

exit;

w_id_aggreg_type_ome_d3