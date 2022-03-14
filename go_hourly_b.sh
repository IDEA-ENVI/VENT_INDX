. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin
cd $bin

login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`

cd $bin

#echo "Generovani pro ETC/ACC  :                         " `date` > $bin/go_hourly_b.log
# nasleduje spusteni generovani do XML
#sqlrun -f./sqlrun.cfg -r2 -l$bin/log/etc_export_hourly.log -detc_export_hourly -g"3"  -u$login_w -p$passwd_w -k1 >$bin/log/etc_export_hourly_1.log 2> $bin/log/etc_export_hourly_2.log
#sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_etc.log -sgo_hourly_etc.sql -u$login_w -p$passwd_w -k1 >$bin/log/go_hourly_etc_1.log 2> $bin/log/go_hourly_etc_2.log
#sendxml.pl /4USERS/caqr/pollution/export_ETC/cz_hourly.xml >>go_hourly_etc.log 2> $bin/log/go_hourly_etc_ftp_2.log

cd $bin/aq_report_generator
echo "Generovani XML pro AQD hodinova davka:            " `date`  > $bin/go_hourly_b.log
go_e2a_hourly.sh

echo "Generovani pro airqualitynow  :                   " `date` >> $bin/go_hourly_b.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_data_export_02_prague.log -dhourly_data_export_02 -g"2,'Prague'"  -u$login_w -p$passwd_w -k1 >$bin/log/hourly_data_export_02_prague_1.log 2> $bin/log/hourly_data_export_02_prague_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_export_02_prague.log -sgo_hourly_export_02_prague.sql -u$login_w -p$passwd_w -k1 >$bin/log/go_hourly_export_02_prague_1.log 2> $bin/log/go_hourly_export_02_prague_2.log
hourly_export_02_prague.ftp  >$bin/log/hourly_export_02_prague_1.log 2>> $bin/log/hourly_export_02_prague_2.log

cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_data_export_02_brno.log -dhourly_data_export_02 -g"2,'Brno'"  -u$login_w -p$passwd_w -k1 >$bin/log/hourly_data_export_02_brno_1.log 2> $bin/log/hourly_data_export_02_brno_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_export_02.log -sgo_hourly_export_02_brno.sql -u$login_w -p$passwd_w -k1 >$bin/log/go_hourly_export_02_Brno_1.log 2> $bin/log/go_hourly_export_02_Brno_2.log
hourly_export_02_brno.ftp > hourly_export_02.log  >$bin/log/hourly_export_02_brno_1.log 2> $bin/log/hourly_export_02_brno_2.log

echo "Generovani pro AIM regulaci:                      " `date` >> $bin/go_hourly_b.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_regulation.log -dhourly_index_regulation -g"0"  -u$login_w -p$passwd_w -k1 >$bin/log/hourly_index_regulation_1.log 2> $bin/log/hourly_index_regulation_2.log

echo "Generovani hodinoveho AIM regulation do xhtml:    " `date` >> $bin/go_hourly_b.log
cd $bin
cd isko_web_generator
go_aim_regulation.sh     >$bin/log/go_svrs_1.log 2> $bin/log/go_svrs_2.log

echo "Generovani slovniku pro Swing:                    " `date` >> $bin/go_hourly_b.log
cd
cp .netrc_1 .netrc
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/export_data_dictionary.log -dexport_data_dictionary -g"1" -u$login_w -p$passwd_w -k1 >$bin/log/export_data_dictionary_1.log 2> $bin/log/export_data_dictionary_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_swing.log -sgo_swing.sql -u$login_w -p$passwd_w -k1 >$bin/log/go_swing_1.log 2> $bin/log/go_swing_2.log
data_pro_swing.ftp  >$bin/log/data_pro_swing_1.log 2>> $bin/log/data_pro_swing_2.log
cd
cp .netrc_main .netrc

#echo "Replikace z SDNES:                               " `date` >> $bin/go_hourly_b.log
#sqlrun -f./sqlrun.cfg -r2 -l$bin/log/i_sdnes_oper_data.log -di_sdnes_oper_data -g"'1','0','1'"  -u$login_w -p$passwd_w -k1

echo "Konec:                                            " `date` >> $bin/go_hourly_b.log

exit 0