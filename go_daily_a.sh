. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`

echo "Rebuild tabulek pro dbsaturation                " `date` > $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r1 -lrebuild_db_saturation.log -srebuild_db_saturation.sql -u$login_w -p$passwd_w -k1

echo "Ruseni starsich HTML pro SVRS                   " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r1 -ldelete_svrs_html.log -sdelete_svrs_html.sql -u$login_w -p$passwd_w -k1

echo "Generovani zaplneni tablespaces pro GaGReport   " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r2 -lnov_db_space.log -dnov.nov_db_space  -g"'null'" -u$login_w -p$passwd_w -k1

echo "Ruseni alarmu starsich nez 365 dni              " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r1 -lalarm_delete.log -salarm_delete.sql -u$login_w -p$passwd_w -k1

echo "Vypocet zaplneni databaze letos                 " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r2 -lday_satur_0.log -di_dbproc_db_saturation_02 -g"0"  -u$login_w -p$passwd_w -k1

echo "Vypocet zaplneni databaze vloni                 " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r2 -lday_satur_1.log -di_dbproc_db_saturation_02 -g"-1" -u$login_w -p$passwd_w -k1

echo "Vypocet zaplneni databaze flagy:                " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r2 -li_flag_satur_0.log -di_dbproc_flag_saturation_01 -g"0,'y'"   -u$login_w -p$passwd_w -k1
sqlrun -f./sqlrun.cfg -r2 -li_flag_satur_1.log -di_dbproc_flag_saturation_01 -g"-1,'n'"  -u$login_w -p$passwd_w -k1
sqlrun -f./sqlrun.cfg -r2 -li_flag_satur_2.log -di_dbproc_flag_saturation_01 -g"-2,'n'"  -u$login_w -p$passwd_w -k1

echo "Generovani emailu pro imise:                    " `date` >> $bin/go_daily_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -li_email_data_generator.log -di_email_data_generator -g"0"  -u$login_w -p$passwd_w -k1

echo "Generovani emailu pro emise:                    " `date` >> $bin/go_daily_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -le_email_data_generator.log -de_email_data_generator -g"1"  -u$login_w -p$passwd_w -k1
echo "Zasilani emailu:                                " `date` >> $bin/go_daily_a.log
cd $bin
cd mail_sender
go_email.sh

echo "Refresh tabulky d_plant v emisich               " `date` >> $bin/go_daily_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r1 -ldaily_d_plant.log -sdaily_d_plant.sql  -u$login_w -p$passwd_w -k1

echo "Vypocet agregovanych udaju za UFP:              " `date` >> $bin/go_daily_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -lufp_aggreg.log -dpollution.ufp_aggreg -g"1" -u$login_w -p$passwd_w -k1

cd $bin
login_w=`awk '{ print $4 }' ../.precipitation`
passwd_w=`awk '{ print $6 }' ../.precipitation`
#echo "Generovani zmenenych lokalit - srazky :         " `date` >> $bin/go_daily_a.log
#sqlrun -f./sqlrun.cfg -r2 -lp_generate_cards_auto.log -dp_generate_cards_auto -g"2009,1" -u$login_w -p$passwd_w -k1

echo "Generovani zaplneni db - srazky :               " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r2 -lday_satur_02.log -dp_dbproc_db_saturation_01 -g"0"  -u$login_w -p$passwd_w -k1
sqlrun -f./sqlrun.cfg -r2 -lday_satur_03.log -dp_dbproc_db_saturation_01 -g"-1" -u$login_w -p$passwd_w -k1
sqlrun -f./sqlrun.cfg -r2 -lday_satur_04.log -dp_dbproc_db_saturation_01 -g"-2" -u$login_w -p$passwd_w -k1

echo "Vypocet zaplneni srazkove databaze flagy:       " `date` >> $bin/go_daily_a.log
sqlrun -f./sqlrun.cfg -r2 -lp_flag_satur_0.log -dp_dbproc_flag_saturation_01 -g"0,'y'"   -u$login_w -p$passwd_w -k1
sqlrun -f./sqlrun.cfg -r2 -lp_flag_satur_1.log -dp_dbproc_flag_saturation_01 -g"-1,'n'"  -u$login_w -p$passwd_w -k1
sqlrun -f./sqlrun.cfg -r2 -lp_flag_satur_2.log -dp_dbproc_flag_saturation_01 -g"-2,'n'"  -u$login_w -p$passwd_w -k1

echo "Generovani imisnich lokalit na portal:          " `date` >> $bin/go_daily_a.log
cd $bin
cd isko_web_generator
go_locality.sh

echo "Generovani dbsaturation:                        " `date` >> $bin/go_daily_a.log
cd $bin
cd isko_web_generator
go_dbsaturation.sh

echo "Generovani lc_count:                            " `date` >> $bin/go_daily_a.log
cd $bin
cd isko_web_generator
go_lc_count.sh

echo "Konec:                                          " `date` >> $bin/go_daily_a.log