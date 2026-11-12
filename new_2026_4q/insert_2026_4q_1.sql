delete from grid_c_interval;
insert into grid_c_interval (id,interval,abbrev) values (1,'0000-00-01 00:00:00','1d') ;
insert into grid_c_interval (id,interval,abbrev) values (2,'0000-01-00 00:00:00','1m') ;
insert into grid_c_interval (id,interval,abbrev) values (3,'0001-00-00 00:00:00','1y') ;


delete from grid_c_aggreg_type;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (1 ,1 ,1 ,3,'avg(1h)/1d','Den: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m²/s','VI_průměr_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (2 ,2 ,2 ,3,'avg(1h)/1m','Měsíc: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m²/s','VI_průměr_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (3 ,3 ,3 ,3,'avg(1h)/1y','Rok: aritmetický průměr ventilačních indexů','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m²/s','VI_průměr_m²·s⁻¹') ;

insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (4 ,4 ,1 ,3,'%/1d VD','Den: Velmi dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','VDRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (5 ,5 ,1 ,3,'%/1d D' ,'Den: Dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','DRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (6 ,6 ,1 ,3,'%/1d MN','Den: Mírně nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','MNRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (7 ,7 ,1 ,3,'%/1d N' ,'Den: Nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','NRP_m²·s⁻¹') ;

insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (8 ,8 ,2 ,3,'%/1m VD','Měsíc: Velmi dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','VDRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (9 ,9 ,2 ,3,'%/1m D' ,'Měsíc: Dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','DRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (10,10,2 ,3,'%/1m MN','Měsíc: Mírně nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','MNRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (11,11,2 ,3,'%/1m N' ,'Měsíc: Nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','NRP_m²·s⁻¹') ;

insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (12,12,3 ,3,'%/1y VD','Rok: Velmi dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','VDRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (13,13,3 ,3,'%/1y D' ,'Rok: Dobré RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','DRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (14,14,3 ,3,'%/1y MN','Rok: Mírně nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','MNRP_m²·s⁻¹') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (15,15,3 ,3,'%/1y N' ,'Rok: Nepříznivé RP - četnosti v % podle OME','Zápis četnosti proběhne bez ohledu na množství dat','m²/s','NRP_m²·s⁻¹') ;
---
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (16,16,1 ,2,'avg(1h)/1d','Den: aritmetický průměr teploty','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','K','T2m_průměr_K') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (17,17,2 ,2,'avg(1h)/1m','Měsíc: aritmetický průměr teploty','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','K','T2m_průměr_K') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (18,18,3 ,2,'avg(1h)/1y','Rok: aritmetický průměr teploty','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','K','T2m_průměr_K') ;
---
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (19,19,1 ,1,'avg(1h)/1d','Den: aritmetický průměr PBL','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m','PBL_průměr_m') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (20,20,2 ,1,'avg(1h)/1m','Měsíc: aritmetický průměr PBL','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m','PBL_průměr_m') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (21,21,3 ,1,'avg(1h)/1y','Rok: aritmetický průměr PBL','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m','PBL_průměr_m') ;
---
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (22,22,1 ,1,'med(1h)/1d','Den: medián PBL','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m','PBL_medián_m') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (23,23,2 ,1,'med(1h)/1m','Měsíc: medián PBL','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m','PBL_medián_m') ;
insert into grid_c_aggreg_type (id,fixed_id,id_interval,id_grid_component,abbrev,name,description,unit,column_name) values (24,24,3 ,1,'med(1h)/1y','Rok: medián PBL','Minimální počet dat pro provedení výpočtu je definován v databázi. Viz GagReport','m','PBL_medián_m') ;

delete from grid_c_class;
insert into grid_c_class (id,class,code,name,description,value_from,value_to) values (1,1,'VD','Velmi dobré RP','četnost hodinových hodnot v %'     ,8600,null);
insert into grid_c_class (id,class,code,name,description,value_from,value_to) values (2,2,'D' ,'Dobré RP','četnost hodinových hodnot v %'           ,2800,8600);
insert into grid_c_class (id,class,code,name,description,value_from,value_to) values (3,3,'MN','Mírně nepříznivé RP','četnost hodinových hodnot v %',1700,2800);
insert into grid_c_class (id,class,code,name,description,value_from,value_to) values (4,4,'N' ,'Nepříznivé RP','četnost hodinových hodnot v %'      ,0,1700);

delete from grid_c_value_type;
insert into grid_c_value_type (id,fixed_id,abbrev,name,description)values (1,1,'valid','Platná data','Platná data') ;
insert into grid_c_value_type (id,fixed_id,abbrev,name,description)values (2,2,'error','Neplatná data','Neplatná data') ;

exit;