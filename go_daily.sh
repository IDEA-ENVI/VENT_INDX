. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`

echo "Analyza datovych tabulek:                       " `date` > $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/analyze.log -di_sql_prepare_data -g"'analyze'" -u$login_w -p$passwd_w -k1 >$bin/log/analyze_1.log 2> $bin/log/analyze_2.log

echo "Prehled poctu lokalit v aktualni cas:           " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/i_dbproc_lc_count_01.log -di_dbproc_lc_count_01 -g"0" -u$login_w -p$passwd_w -k1 >$bin/log/i_dbproc_lc_count_01_1.log 2> $bin/log/i_dbproc_lc_count_01_2.log

#echo "Generovani slovniku pro Swing:                  " `date` >> $bin/go_daily.log # to se dela hodinove
#sqlrun -f./sqlrun.cfg -r2 -l$bin/log/export_data_dictionary_daily.log -dexport_data_dictionary -g"1" -u$login_w -p$passwd_w -k1 >$bin/log/export_data_dictionary_daily_1.log 2> $bin/log/export_data_dictionary_daily_2.log
#sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_swing.log -sgo_swing.sql -u$login_w -p$passwd_w -k1 >$bin/log/go_swing_1.log 2> $bin/log/go_swing_2.log

echo "Prehrani op. dat za 24 hodin:                   " `date` >> $bin/go_daily.log
go_daily_1.sh /export/home/provoz/bin/iso99.d /4USERS/caqr/pollution/data_oper/tmp/daily/routine /4USERS/caqr/pollution/data_oper/archive/daily/routine

echo "Prehrani oprav op. dat za 24 hodin:             " `date` >> $bin/go_daily.log
go_daily_2.sh /export/home/provoz/bin/iso99opr.d /4USERS/caqr/pollution/data_oper/tmp/daily/repair /4USERS/caqr/pollution/data_oper/archive/daily/repair

cd $bin
echo "Generovani prekroceni limitu za letosni rok:    " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/ps_dbproc_tab_01.log -dps_dbproc_tab_01 -g"-0,'y'" -u$login_w -p$passwd_w -k1 >$bin/log/ps_dbproc_tab_01_1.log 2> $bin/log/ps_dbproc_tab_01_2.log

MM=`$bin/shiftdate -0 mm`
# Pro mesice 1 az 6 pocitat i za lonsky rok. Jinak jen letos.
if [ $MM -lt 7 ] 
then
  echo "Generovani prekroceni limitu za predchozi rok:  " `date` >> $bin/go_daily.log
  sqlrun -f./sqlrun.cfg -r2 -l$bin/log/ps_dbproc_tab_01_last_year.log -dps_dbproc_tab_01 -g"-1,'n'" -u$login_w -p$passwd_w -k1 >$bin/log/ps_dbproc_tab_01_last_year_1.log 2> $bin/log/ps_dbproc_tab_01_last_year_2.log
fi

echo "Vypocet klouzavych rocnich prumeru:             " `date` >> $bin/go_daily.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/slide_averages.log -dslide_averages -g"120" -u$login_w -p$passwd_w -k1

echo "Generovani exceed:                              " `date` >> $bin/go_daily.log
cd $bin
cd isko_web_generator
go_exceed.sh              >$bin/log/go_exceed_1.log 2> $bin/log/go_exceed_2.log

echo "Generovani prehledu neplatnych rocnich prumeru  " `date` >> $bin/go_daily.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/invalid_year_average.log -dinvalid_year_average -g"-0,'y'" -u$login_w -p$passwd_w -k1 >$bin/log/invalid_year_average_0_1.log 2> $bin/log/invalid_year_average_0_2.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/invalid_year_average.log -dinvalid_year_average -g"-1,'n'" -u$login_w -p$passwd_w -k1 >$bin/log/invalid_year_average_1_1.log 2> $bin/log/invalid_year_average_1_2.log

cd isko_web_generator
go_invalid_daily_avgs.sh              >$bin/log/invalid_daily_avgs_1.log 2> $bin/log/invalid_daily_avgs_sh_2.log


cd $bin
echo "Hledani nepravdepodobnych udaju:                " `date` >> $bin/go_daily.log
queer -f./queer.cfg -m15 -d60 -k1 -i1 -r1 -v2 -g2 -l3 -u$login_w -p$passwd_w       >$bin/log/queer_1.log 2> $bin/log/queer_2.log

echo "Hledani nepravdep. udaju urcenych porovnanim:   " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/cp_compare_01.log -dcp_compare_01 -g"'30','19'" -u$login_w -p$passwd_w -k1 >$bin/log/cp_compare_01_1.log 2> $bin/log/cp_compare_01_2.log

echo "Generovani XML pro AQD denni davka:             " `date` >> $bin/go_daily.log
cd $bin/aq_report_generator
go_e2a_daily.sh

echo "Generovani queer do html:                       " `date` >> $bin/go_daily.log
cd $bin
cd isko_web_generator
go_queer.sh              >$bin/log/go_queer_1.log 2> $bin/log/go_queer_2.log

echo "Generovani queer compare do html:               " `date` >> $bin/go_daily.log
cd $bin
cd isko_web_generator
go_queer_compare.sh     >$bin/log/go_queer_compare_1.log 2> $bin/log/go_queer_compare_2.log

cd $bin
echo "Vypocet pro GaGReport PM10                      " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/i_GaGReport_PM10.log -dpollution.i_gag_graph -g"'PM10'"  -u$login_w -p$passwd_w -k1 >$bin/log/gag_graph_pm10_1.log 2> $bin/log/gag_graph_pm10_2.log
echo "Vypocet pro GaGReport SO2                       " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/i_GaGReport_SO2.log  -dpollution.i_gag_graph -g"'SO2'"   -u$login_w -p$passwd_w -k1 >$bin/log/gag_graph_so2_1.log 2> $bin/log/gag_graph_so2_2.log
echo "Vypocet pro GaGReport NOx                       " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/i_GaGReport_NOx.log  -dpollution.i_gag_graph -g"'NOx'"   -u$login_w -p$passwd_w -k1 >$bin/log/gag_graph_nox_1.log 2> $bin/log/gag_graph_nox_2.log
echo "Vypocet pro GaGReport O3                        " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/i_GaGReport_O3.log   -dpollution.i_gag_graph -g"'O3'"    -u$login_w -p$passwd_w -k1 >$bin/log/gag_graph_o3_1.log 2> $bin/log/gag_graph_o3_2.log
echo "Vypocet pro GaGReport SPM                       " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/i_GaGReport_SPM.log  -dpollution.i_gag_graph -g"'SPM'"  -u$login_w -p$passwd_w -k1 >$bin/log/gag_graph_spm_1.log 2> $bin/log/gag_graph_spm_2.log

echo "Generovani unireport:                           " `date` >> $bin/go_daily.log
cd $bin
cd unireport_generator
go_unireport_pollution.sh      >$bin/log/go_unireport_pollution_1.log     2> $bin/log/go_unireport_pollution_2.log
go_unireport_precipitation.sh  >$bin/log/go_unireport_precipitation_1.log 2> $bin/log/go_unireport_precipitation_2.log
go_unireport_error.sh          >$bin/log/go_unireport_error_1.log         2> $bin/log/go_unireport_error_2.log

echo "Prehrani paralelnich mereni na virtualni:       " `date` >> $bin/go_daily.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -lrecord_parallel_oper.log -drecord_parallel -g"'i_c_data_record_oper'" -u$login_w -p$passwd_w -k1
sqlrun -f./sqlrun.cfg -r2 -lrecord_parallel_verif.log -drecord_parallel -g"'i_c_data_record_verif'" -u$login_w -p$passwd_w -k1

echo "Vypocet agreg. udaju za ventilacni index        " `date` >> $bin/go_daily.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/vix_aggreg.log -dvix.vix_aggreg -g"'1'" -u$login_w -p$passwd_w -k1 >$bin/log/vix_aggreg_1.log 2> $bin/log/vix_aggreg_2.log

echo "Konec:                                          " `date` >> $bin/go_daily.log