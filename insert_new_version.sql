delete from vix_c_aggreg_type;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (1 ,1 ,1,'avg(1h)/1d','Den: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (2 ,2 ,2,'avg(1h)/1m','Měsíc: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (3 ,3 ,3,'avg(1h)/1y','Rok: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;

insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (4 ,4 ,1,'%/1d VD','Den: Velmi dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (5 ,5 ,1,'%/1d D' ,'Den: Dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (6 ,6 ,1,'%/1d MN','Den: Mírně nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (7 ,7 ,1,'%/1d N' ,'Den: Nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;

insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (8 ,8 ,2,'%/1m VD','Měsíc: Velmi dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (9 ,9 ,2,'%/1m D' ,'Měsíc: Dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (10,10,2,'%/1m MN','Měsíc: Mírně nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (11,11,2,'%/1m N' ,'Měsíc: Nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;

insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (12,12,3,'%/1y VD','Rok: Velmi dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (13,13,3,'%/1y D' ,'Rok: Dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (14,14,3,'%/1y MN','Rok: Mírně nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;
insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (15,15,3,'%/1y N' ,'Rok: Nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat') ;

--insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (16,16,1,'CPP','Den: Třída rozptylových podmínek 1 až 4.','Čtyři třídy rozptylových podmínek charakterizované čísly 1 až 4.') ;

--insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (17,17,1,'kv50/1d','Den: Medián za den','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;
--insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (18,18,2,'kv50/1m','Den: Medián za měsíc','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;
--insert into vix_c_aggreg_type (id,fixed_id,id_interval,abbrev,name,description) values (19,19,3,'kv50/1y','Den: Medián za rok','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport') ;


delete from vix_c_class;
insert into vix_c_class (id,class,code,name,description,value_from,value_to) values (1,1,'VD','Velmi dobré RP','četnost hodinových hodnot v %'     ,8600,null);
insert into vix_c_class (id,class,code,name,description,value_from,value_to) values (2,2,'D' ,'Dobré RP','četnost hodinových hodnot v %'           ,2800,8600);
insert into vix_c_class (id,class,code,name,description,value_from,value_to) values (3,3,'MN','Mírně nepříznivé RP','četnost hodinových hodnot v %',1700,2800);
insert into vix_c_class (id,class,code,name,description,value_from,value_to) values (4,4,'N' ,'Nepříznivé RP','četnost hodinových hodnot v %'      ,0,1700);

exit;