delete from vt_c_interval;
insert into vt_c_interval (id,interval,abbrev) values (1,'0000-00-01 00:00:00','1d');
insert into vt_c_interval (id,interval,abbrev) values (2,'0000-01-00 00:00:00','1m');
insert into vt_c_interval (id,interval,abbrev) values (3,'0001-00-00 00:00:00','1y');

delete from vt_c_value_type;
insert into vt_c_value_type (id,fixed_id,abbrev,name,description)values (1,1,'valid','Platná data','Platná data') ;
insert into vt_c_value_type (id,fixed_id,abbrev,name,description)values (2,2,'error','Neplatná data','Neplatná data') ;

delete from vt_c_aggreg_type;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (1,1,'avg(1h)/1d','Den: aritmetický prùmìr ventilaèních indexù','Minimální poèet dat pro provedení výpoètu je definován v databázi. Viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (2,2,'avg(1h)/1m','Mìsíc: aritmetický prùmìr ventilaèních indexù','Minimální poèet dat pro provedení výpoètu je definován v databázi. Viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (3,3,'avg(1h)/1y','Rok: aritmetický prùmìr ventilaèních indexù','Minimální poèet dat pro provedení výpoètu je definován v databázi. Viz GagReport') ;

insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (4,4,'%/1d','Den: èetnosti v % podle OME','Minimální poèet dat pro provedení výpoètu je definován v databázi. Definice èetností viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (5,5,'%/1m','Mìsíc: èetnosti v % podle OME','Minimální poèet dat pro provedení výpoètu je definován v databázi. Definice èetností viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (6,6,'%/1y','Rok: èetnosti v % podle OME','Minimální poèet dat pro provedení výpoètu je definován v databázi. Definice èetností viz GagReport') ;

insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (7,7,'value/1d','Den: tøída zaøazení VI podle CPP.','Nabývá hodnotu od 1 do 4. Viz GagReport') ;


delete from vt_c_frequency_class_ome;
insert into vt_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (1,'D' ,'Dobré RP','Èetnost hodinových hodnot v %'           ,3000,null);
insert into vt_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (2,'MN','Mírnì nepøíznivé RP','Èetnost hodinových hodnot v %',1100,3000);
insert into vt_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (3,'N' ,'Nepøíznivé RP','Èetnost hodinových hodnot v %'      ,0,1100);


delete from vt_c_class_cpp;
insert into vt_c_class_cpp (id,class,code,name,description) values (1,1,'1D'   ,'Dobré RP','x');
insert into vt_c_class_cpp (id,class,code,name,description) values (2,2,'2CMN' ,'Èásteènì mírnì neøíznivé RP','x');
insert into vt_c_class_cpp (id,class,code,name,description) values (3,3,'3MN'  ,'Mírnì nepøíznivé RP','x');
insert into vt_c_class_cpp (id,class,code,name,description) values (4,4,'4N'   ,'Nepøíznivé RP','x');

exit;
