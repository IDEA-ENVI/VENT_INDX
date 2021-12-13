delete from vix_c_interval;
insert into vix_c_interval (id,interval,abbrev) values (1,'0000-00-01 00:00:00','1d');
insert into vix_c_interval (id,interval,abbrev) values (2,'0000-01-00 00:00:00','1m');
insert into vix_c_interval (id,interval,abbrev) values (3,'0001-00-00 00:00:00','1y');

delete from vix_c_value_type;
insert into vix_c_value_type (id,fixed_id,abbrev,name,description)values (1,1,'valid','Platná data','Platná data') ;
insert into vix_c_value_type (id,fixed_id,abbrev,name,description)values (2,2,'error','Neplatná data','Neplatná data') ;

delete from vix_c_aggreg_type;
insert into vix_c_aggreg_type (id,fixed_id,abbrev,name,description) values (1,1,'avg(1h)/1d','Den: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;
insert into vix_c_aggreg_type (id,fixed_id,abbrev,name,description) values (2,2,'avg(1h)/1m','Měsíc: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;
insert into vix_c_aggreg_type (id,fixed_id,abbrev,name,description) values (3,3,'avg(1h)/1y','Rok: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;

insert into vix_c_aggreg_type (id,fixed_id,abbrev,name,description) values (4,4,'%/1d','Den: četnosti v % podle OME','Minimální počet dat pro provedení výpočtu je definován v databázi. Definice četností viz GagReport') ;
insert into vix_c_aggreg_type (id,fixed_id,abbrev,name,description) values (5,5,'%/1m','Měsíc: četnosti v % podle OME','Minimální počet dat pro provedení výpočtu je definován v databázi. Definice četností viz GagReport') ;
insert into vix_c_aggreg_type (id,fixed_id,abbrev,name,description) values (6,6,'%/1y','Rok: četnosti v % podle OME','Minimální počet dat pro provedení výpočtu je definován v databázi. Definice četností viz GagReport') ;

insert into vix_c_aggreg_type (id,fixed_id,abbrev,name,description) values (7,7,'value/1d','Den: třída zařazení VI podle CPP.','Nabývá hodnotu od 1 do 4. Viz GagReport') ;


delete from vix_c_frequency_class_ome;
insert into vix_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (1,'D' ,'Dobré RP','četnost hodinových hodnot v %'           ,3000,null);
insert into vix_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (2,'MN','Mírně nepříznivé RP','četnost hodinových hodnot v %',1100,3000);
insert into vix_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (3,'N' ,'Nepříznivé RP','četnost hodinových hodnot v %'      ,0,1100);


delete from vix_c_class_cpp;
insert into vix_c_class_cpp (id,class,code,name,description) values (1,1,'1D'   ,'Dobré RP','x');
insert into vix_c_class_cpp (id,class,code,name,description) values (2,2,'2CMN' ,'Částečně mírně neříznivé RP','x');
insert into vix_c_class_cpp (id,class,code,name,description) values (3,3,'3MN'  ,'Mírně nepříznivé RP','x');
insert into vix_c_class_cpp (id,class,code,name,description) values (4,4,'4N'   ,'Nepříznivé RP','x');


delete from vix_c_area;
insert into vix_c_area (id,fixed_id,code,name) values (01,1000,'CZ010' ,'Aglomerace Praha');
insert into vix_c_area (id,fixed_id,code,name) values (02,2000,'CZ020' ,'Středočeský kraj');
insert into vix_c_area (id,fixed_id,code,name) values (03,3100,'CZ031' ,'Jihočeský kraj');
insert into vix_c_area (id,fixed_id,code,name) values (04,3200,'CZ032' ,'Plzeňský kraj');
insert into vix_c_area (id,fixed_id,code,name) values (05,4100,'CZ041' ,'Karlovarský kraj');
insert into vix_c_area (id,fixed_id,code,name) values (06,4200,'CZ042' ,'Ústecký kraj');
insert into vix_c_area (id,fixed_id,code,name) values (07,5100,'CZ051' ,'Liberecký kraj');
insert into vix_c_area (id,fixed_id,code,name) values (08,5200,'CZ052' ,'Královéhradecký kraj');
insert into vix_c_area (id,fixed_id,code,name) values (09,5300,'CZ053' ,'Pardubický kraj');
insert into vix_c_area (id,fixed_id,code,name) values (10,6300,'CZ063' ,'Kraj Vysočina');
insert into vix_c_area (id,fixed_id,code,name) values (11,6410,'CZ064Z','Jihomoravský kraj bez aglomerace Brno');
insert into vix_c_area (id,fixed_id,code,name) values (12,6420,'CZ064A','Aglomerace Brno');
insert into vix_c_area (id,fixed_id,code,name) values (13,7100,'CZ071' ,'Olomoucký kraj');
insert into vix_c_area (id,fixed_id,code,name) values (14,7200,'CZ072' ,'Zlínský kraj');
insert into vix_c_area (id,fixed_id,code,name) values (15,8010,'CZ080Z','Moravskoslezský kraj bez aglomerace O/K/F-M');
insert into vix_c_area (id,fixed_id,code,name) values (16,8020,'CZ080A','Aglomerace Ostrava/Karviná/Frýdek-Místek');

insert into vix.vix_c_area (id, fixed_id, code, name) values (0,1,'CZ','Česká republika');

exit;


