drop table vix_c_data_record;


create table vix_c_data_record
(
   id         number(8,0) not null ,
   id_area    number(8,0) not null ,
   start_time date not null,
   end_time   date not null);

alter table vix_c_data_record           add constraint pk_vix_c_data_record          primary key (id) ;



grant select,insert,update,delete on vix_c_data_record to vix_rw_role;

drop sequence vix_id_data_record;
create sequence vix_id_data_record
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 10
cycle
;
grant select on vix_id_data_record to vix_rw_role;


exit;