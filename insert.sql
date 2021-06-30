delete from vt_c_interval;
insert into vt_c_interval (id,interval,abbrev) values (1,'0000-00-01 00:00:00','1d');
insert into vt_c_interval (id,interval,abbrev) values (2,'0000-01-00 00:00:00','1m');
insert into vt_c_interval (id,interval,abbrev) values (3,'0001-00-00 00:00:00','1y');

delete from vt_c_value_type;
insert into vt_c_value_type (id,fixed_id,abbrev,name,description)values (1,1,'valid','Platn� data','Platn� data') ;
insert into vt_c_value_type (id,fixed_id,abbrev,name,description)values (2,2,'error','Neplatn� data','Neplatn� data') ;

delete from vt_c_aggreg_type;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (1,1,'avg(1h)/1d','Den: aritmetick� pr�m�r ventila�n�ch index�','Minim�ln� po�et dat pro proveden� v�po�tu je definov�n v datab�zi. Viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (2,2,'avg(1h)/1m','M�s�c: aritmetick� pr�m�r ventila�n�ch index�','Minim�ln� po�et dat pro proveden� v�po�tu je definov�n v datab�zi. Viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (3,3,'avg(1h)/1y','Rok: aritmetick� pr�m�r ventila�n�ch index�','Minim�ln� po�et dat pro proveden� v�po�tu je definov�n v datab�zi. Viz GagReport') ;

insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (4,4,'%/1d','Den: �etnosti v % podle OME','Minim�ln� po�et dat pro proveden� v�po�tu je definov�n v datab�zi. Definice �etnost� viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (5,5,'%/1m','M�s�c: �etnosti v % podle OME','Minim�ln� po�et dat pro proveden� v�po�tu je definov�n v datab�zi. Definice �etnost� viz GagReport') ;
insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (6,6,'%/1y','Rok: �etnosti v % podle OME','Minim�ln� po�et dat pro proveden� v�po�tu je definov�n v datab�zi. Definice �etnost� viz GagReport') ;

insert into vt_c_aggreg_type (id,fixed_id,abbrev,name,description) values (7,7,'value/1d','Den: t��da za�azen� VI podle CPP.','Nab�v� hodnotu od 1 do 4. Viz GagReport') ;


delete from vt_c_frequency_class_ome;
insert into vt_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (1,'D' ,'Dobr� RP','�etnost hodinov�ch hodnot v %'           ,3000,null);
insert into vt_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (2,'MN','M�rn� nep��zniv� RP','�etnost hodinov�ch hodnot v %',1100,3000);
insert into vt_c_frequency_class_ome (id,code,name,description,value_from,value_to) values (3,'N' ,'Nep��zniv� RP','�etnost hodinov�ch hodnot v %'      ,0,1100);


delete from vt_c_class_cpp;
insert into vt_c_class_cpp (id,class,code,name,description) values (1,1,'1D'   ,'Dobr� RP','x');
insert into vt_c_class_cpp (id,class,code,name,description) values (2,2,'2CMN' ,'��ste�n� m�rn� ne��zniv� RP','x');
insert into vt_c_class_cpp (id,class,code,name,description) values (3,3,'3MN'  ,'M�rn� nep��zniv� RP','x');
insert into vt_c_class_cpp (id,class,code,name,description) values (4,4,'4N'   ,'Nep��zniv� RP','x');

exit;
