. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`


DFW=`date "+%u"` # Den v tydnu: 1-pondeli, 7-nedele


echo "Rebuild tabulek pro tabular_report              " `date` > $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r1 -lrebuild_tabular_report.log -srebuild_tabular_report.sql -u$login_w -p$passwd_w -k1

cd $bin
echo "Vypocet tabelarnich vystupu na internet01:      " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -ltab_report_01.log -dtab_report_01 -g" 44,'0000-01-00 00:00:00','A'" -u$login_w -p$passwd_w -k1
echo "Vypocet tabelarnich vystupu na internet02:      " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -ltab_report_02.log -dtab_report_01 -g" 75,'0000-01-00 00:00:00','A'" -u$login_w -p$passwd_w -k1
echo "Vypocet tabelarnich vystupu na internet03:      " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -ltab_report_03.log -dtab_report_01 -g"106,'0000-01-00 00:00:00','A'" -u$login_w -p$passwd_w -k1

echo "Vypocet tabelarnich vystupu na internet04:      " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -ltab_report_04.log -dtab_report_01 -g" 44,'0000-01-00 00:00:00','M'" -u$login_w -p$passwd_w -k1
echo "Vypocet tabelarnich vystupu na internet05:      " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -ltab_report_05.log -dtab_report_01 -g" 75,'0000-01-00 00:00:00','M'" -u$login_w -p$passwd_w -k1
echo "Vypocet tabelarnich vystupu na internet06:      " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -ltab_report_06.log -dtab_report_01 -g"106,'0000-01-00 00:00:00','M'" -u$login_w -p$passwd_w -k1

echo "Repair tabulek pro tabular_report               " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r1 -lrepair_tabular_report.log -srepair_tabular_report.sql -u$login_w -p$passwd_w -k1

echo "Generovani do html:                             " `date` >> $bin/go_daily_b.log
cd $bin
cd isko_web_generator
go_tab_reports.sh

cd $bin
echo "Generovani spotreby ze stare databaze            "`date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/load_consumption_from_old_db.log -demission.load_consumption_from_old_db -g"-1"  -u$login_w -p$passwd_w -k1  >$bin/log/load_consumption_from_old_db_1.log 2> $bin/log/load_consumption_from_old_db_2.log

cd $bin
echo "Generovani rozdilu v emisich na zdrojxkomin del  "`date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/emis_difference_call.log -demission.emis_difference_call -g"0"  -u$login_w -p$passwd_w -k1  >$bin/log/emis_difference_call_this_year_1.log 2> $bin/log/emis_difference_call_this_year_2.log

cd $bin
echo "Naplneni tabulky c_change_data_year_status_log  " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/change_data_year_status.log -demission.change_data_year_status -g"-1"  -u$login_w -p$passwd_w -k1 >$bin/log/change_data_year_status_1.log 2> $bin/log/change_data_year_status_2.log

echo "Odeslani emailu o chybnych datech v emisich     " `date` >> $bin/go_daily_b.log
cd emis_mail_sender
go.sh            >$bin/log/emis_mail_sender_1.log 2> $bin/log/emis_mail_sender_2.log

echo "Generovani rozdilu v emisich na zdrojxkomin go  " `date` >> $bin/go_daily_b.log
echo "Generovani emisni bilance po okresech a rocich  " `date` >> $bin/go_daily_b.log
echo "Nalezeni vyduchu mimo hranice UTJ:              " `date` >> $bin/go_daily_b.log

cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/emis_difference_call.log -demission.emis_difference_call -g"-1"  -u$login_w -p$passwd_w -k1 >$bin/log/emis_difference_call_last_year_1.log 2> $bin/log/emis_difference_call_last_year_2.log &

if [ $DFW -lt 7 ] # V nedeli pocitame or roku 1980, jindy 4 roky zpet od aktualniho roku.
then
  sqlrun -f./sqlrun.cfg -r2 -l$bin/log/lau1_bilance.log -demission.lau1_bilance -g"-4"  -u$login_w -p$passwd_w -k1 >$bin/log/lau1_bilance_1.log 2> $bin/log/lau1_bilance_2.log &
  sqlrun -f./sqlrun.cfg -r2 -l$bin/log/orp_bilance.log  -demission.orp_bilance -g"-4 "  -u$login_w -p$passwd_w -k1 >$bin/log/orp_bilance_1.log  2> $bin/log/orp_bilance_2.log  &
else
  sqlrun -f./sqlrun.cfg -r2 -l$bin/log/lau1_bilance.log -demission.lau1_bilance -g"1980"  -u$login_w -p$passwd_w -k1 >$bin/log/lau1_bilance_1.log 2> $bin/log/lau1_bilance_2.log &
  sqlrun -f./sqlrun.cfg -r2 -l$bin/log/orp_bilance.log  -demission.orp_bilance  -g"1980"  -u$login_w -p$passwd_w -k1 >$bin/log/orp_bilance_1.log  2> $bin/log/orp_bilance_2.log  &
fi
wait

echo "Vypocet vzdalenosti kominu od UTJ pro akt. roky " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/exhaust_distance.log -dexhaust_distance -g"-999" -u$login_w -p$passwd_w -k1 >$bin/log/exhaust_distance_1a.log 2> $bin/log/exhaust_distance_2a.log

echo "Vypocet vzdalenosti kominu od ADM pro akt. roky " `date` >> $bin/go_daily_b.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/exhaust_distance_adm.log -dexhaust_distance_adm -g"-999" -u$login_w -p$passwd_w -k1 >$bin/log/exhaust_distance_adm_1a.log 2> $bin/log/exhaust_distance_adm_2a.log

cd $bin
echo "Generovani emailu o chybnych datech v emisich   " `date` >> $bin/go_daily_b.log

sqlrun -f./sqlrun.cfg -r2 -l$bin/log/emis_message.log -demission.emis_message -g"-1" -u$login_w -p$passwd_w -k1 >$bin/log/emis_message_1.log 2> $bin/log/emis_message_2.log #select max(year)+1 into w_year from c_year where is_presentation='1';
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/emis_message.log -demission.emis_message -g"-2" -u$login_w -p$passwd_w -k1 >$bin/log/emis_message_1.log 2> $bin/log/emis_message_2.log #select max(year)+2 into w_year from c_year where is_presentation='1';

echo "Generovani unireport:                           " `date` >> $bin/go_daily_b.log
cd $bin
cd unireport_generator
go_unireport_emission.sh       >$bin/log/go_unireport_emission_1.log      2> $bin/log/go_unireport_emission_2.log
go_unireport_error.sh          >$bin/log/go_unireport_error_1.log         2> $bin/log/go_unireport_error_2.log

echo "Generovani adress plant - ADM                   " `date` >> $bin/go_daily_b.log
cd $bin
sqlrun -f./sqlrun.cfg -r1 -lplant_adm.log -splant_adm.sql -u$login_w -p$passwd_w -k1


echo "Konec:                                          " `date` >> $bin/go_daily_b.log