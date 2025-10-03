drop table vix_s_secondary_data cascade constraint;
drop table vix_c_frequency_class_ome cascade constraint;
drop table vix_c_class_cpp cascade constraint;
drop table vix_c_aggreg_type cascade constraint;


drop table vix_c_aggreg_type cascade constraint;
create table vix_c_aggreg_type
(
   id number(8,0) not null ,
   fixed_id number(4) not null,
   id_interval number(8,0) not null ,
   abbrev varchar2(20) not null,
   name nvarchar2(80) not null,
   description  nvarchar2(1600) not null
)
;

drop table vix_c_class cascade constraint;
create table vix_c_class
(
   id number(8,0) not null ,
   class        number(2,0) not null,
   code         varchar2(6) not null,
   name         nvarchar2(80) not null,
   description  nvarchar2(1600) not null,
   value_from   float not null,
   value_to     float
)
;

drop table vix_s_secondary_data cascade constraint;
create table vix_s_secondary_data
(
   id_area number(8,0) not null ,
   start_time date not null,
   id_aggreg_type number(8,0) not null ,
   value float
--   id_class number(8,0)
)
;

alter table vix_c_aggreg_type          add constraint pk_c_aggreg_type         primary key (id) ;

alter table vix_c_class                add constraint pk_vix_c_class           primary key (id) ;
alter table vix_s_secondary_data       add constraint pk_s_secondary_data      primary key (id_area,start_time,id_aggreg_type) ;

create unique index indx_vix_c_class_01         on vix_c_class (class);
create unique index indx_vix_c_class_02         on vix_c_class (code);

alter table vix_c_aggreg_type    add constraint fk_vix_c_aggreg_type_01  foreign key (id_interval) references vix_c_interval (id);
alter table vix_s_secondary_data add constraint fk_s_secondary_data_01  foreign key (id_area) references vix_c_area (id);
alter table vix_s_secondary_data add constraint fk_s_secondary_data_02  foreign key (id_aggreg_type) references vix_c_aggreg_type (id);
--alter table vix_s_secondary_data add constraint fk_s_secondary_data_03  foreign key (id_class) references vix_c_class (id);


grant select,insert,update,delete on vix_c_aggreg_type to vix_rw_role;
grant select,insert,update,delete on vix_s_secondary_data to vix_rw_role;
grant select,insert,update,delete on vix_c_class to vix_rw_role;

exit;