/*
create role vix_rw_role;
grant vix_rw_role to pollution with admin option;
grant vix_rw_role to novak with admin option;
grant vix_rw_role to novakv with admin option;
*/
grant m_read_role to novak with admin option;
grant e_read_role to novak with admin option;
grant vix_rw_role to novak with admin option;


grant m_read_role to novakv with admin option;
grant e_read_role to novakv with admin option;
grant vix_rw_role to novakv with admin option;


drop index indx_vt_c_area_01;
drop table vix_p_primary_data;
drop table vix_s_secondary_data;
drop table vix_c_value_type;
drop table vix_c_aggreg_type;
drop table vix_c_area;
drop table vix_c_frequency_class_ome;
drop table vix_c_class_cpp;
drop table vix_c_interval;


create table vix_c_frequency_class_ome
(
   id number(8,0) not null ,
   code         varchar2(6) not null,
   name         nvarchar2(80) not null,
   description  nvarchar2(1600) not null,
   value_from   float not null,
   value_to     float
)
;
create table vix_c_class_cpp
(
   id number(8,0) not null ,
   class        number(2,0) not null,
   code         varchar2(6) not null,
   name         nvarchar2(80) not null,
   description  nvarchar2(1600) not null
)
;
create table vix_c_area
(
   id number(8,0) not null ,
   fixed_id number(4) not null,
   code varchar2(6) not null,
   name nvarchar2(80) not null
)
;
create table vix_c_aggreg_type
(
   id number(8,0) not null ,
   fixed_id number(4) not null,
   abbrev varchar2(20) not null,
   name nvarchar2(80) not null,
   description  nvarchar2(1600) not null
)
;
create table vix_c_value_type
(
   id number(8,0) not null ,
   fixed_id number(4) not null,
   abbrev varchar2(20) not null,
   name nvarchar2(80) not null,
   description  nvarchar2(1600) not null
)
;
create table vix_c_interval
(
   id number(8,0) not null ,
   interval char(19) not null,
   abbrev varchar2(10) not null
)
;

create table vix_p_primary_data
(
   id_area number(8,0) not null ,
   start_time date not null,
   id_value_type number(8,0) not null ,
   value float not null   
)
;
create table vix_s_secondary_data
(
   id_area number(8,0) not null ,
   start_time date not null,
   id_interval number(8,0) not null ,
   id_aggreg_type number(8,0) not null ,
   value float not null   
)
;
alter table vix_c_value_type           add constraint pk_c_value_type          primary key (id) ;
alter table vix_c_aggreg_type          add constraint pk_c_aggreg_type         primary key (id) ;
alter table vix_c_area                 add constraint pk_c_area                primary key (id) ;
alter table vix_c_frequency_class_ome  add constraint pk_c_frequency_class_ome primary key (id) ;
alter table vix_c_class_cpp            add constraint pk_vix_c_class_cpp        primary key (id) ;
alter table vix_c_interval             add constraint pk_c_interval            primary key (id) ;

alter table vix_p_primary_data         add constraint pk_p_primary_data        primary key (id_area,start_time,id_value_type) ;
alter table vix_s_secondary_data       add constraint pk_s_secondary_data      primary key (id_area,start_time,id_interval,id_aggreg_type) ;


create unique index indx_vix_c_frequency_class_ome  on vix_c_frequency_class_ome (code);
create unique index indx_vix_c_class_cpp_01         on vix_c_class_cpp (class);
create unique index indx_vix_c_class_cpp_02         on vix_c_class_cpp (code);
create unique index indx_vix_c_area_01              on vix_c_area (fixed_id);
create unique index indx_vix_c_area_02              on vix_c_area (code);
create unique index indx_vix_c_aggreg_type          on vix_c_aggreg_type (fixed_id);
create unique index indx_vix_c_value_type           on vix_c_value_type (fixed_id);
create unique index indx_vix_c_interval_01          on vix_c_interval (interval);
create unique index indx_vix_c_interval_02          on vix_c_interval (abbrev);


alter table vix_p_primary_data add constraint fk_p_primary_data_01  foreign key (id_area) references vix_c_area (id);
alter table vix_p_primary_data add constraint fk_p_primary_data_03  foreign key (id_value_type) references vix_c_value_type (id);

alter table vix_s_secondary_data add constraint fk_s_secondary_data_01  foreign key (id_area) references vix_c_area (id);
alter table vix_s_secondary_data add constraint fk_s_secondary_data_02  foreign key (id_interval) references vix_c_interval (id);
alter table vix_s_secondary_data add constraint fk_s_secondary_data_03  foreign key (id_aggreg_type) references vix_c_aggreg_type (id);



grant select,insert,update,delete on vix_p_primary_data to vix_rw_role;
grant select,insert,update,delete on vix_s_secondary_data to vix_rw_role;
grant select,insert,update,delete on vix_c_value_type to vix_rw_role;
grant select,insert,update,delete on vix_c_aggreg_type to vix_rw_role;
grant select,insert,update,delete on vix_c_area to vix_rw_role;
grant select,insert,update,delete on vix_c_frequency_class_ome to vix_rw_role;
grant select,insert,update,delete on vix_c_class_cpp to vix_rw_role;
grant select,insert,update,delete on vix_c_interval to vix_rw_role;

exit;