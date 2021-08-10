create tablespace vix datafile 'vix.dat'
size 40M autoextend on online;

CREATE USER vix  
    IDENTIFIED BY asd
    DEFAULT TABLESPACE vix  
    TEMPORARY TABLESPACE temp;
grant dba to vix;
exit

/*
CREATE BIGFILE TABLESPACE bigtbs_01
  DATAFILE 'bigtbs_f1.dat'
  SIZE 20M AUTOEXTEND ON;
CREATE TABLESPACE tbs_01 
   DATAFILE 'tbs_f2.dat' SIZE 400M 
   ONLINE;
*/
exit;