. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`

cd $bin

echo "Naplneni tabulky i_c_data_record_db_saturation: " `date` > $bin/go_daily_c.log
#toto bylo preneseno ze scriptu go_daily_a.sh protoze -di_sql_prepare_data -g"'data_record_oper'" rusi data v i_c_data_record_oper
sqlrun -f./sqlrun.cfg -r2 -lprepare_db_saturation.log -di_sql_prepare_data -g"'db_saturation'" -u$login_w -p$passwd_w -k1


echo "Uprava tabulky i_c_data_record_oper krok 1:     " `date` >> $bin/go_daily_c.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/data_record_oper.log -di_sql_prepare_data -g"'data_record_oper'" -u$login_w -p$passwd_w -k1 >$bin/log/data_record_oper_1.log 2> $bin/log/data_record_oper_2.log

echo "Uprava tabulky i_c_data_record_oper krok 2:     " `date` >> $bin/go_daily_c.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/data_record_oper2.log -di_sql_prepare_data -g"'data_record_oper2'" -u$login_w -p$passwd_w -k1 >$bin/log/data_record_oper2_1.log 2> $bin/log/data_record_oper2_2.log

echo "Setrepani i_c_data_record_oper_1 az 3:          " `date` >> $bin/go_daily_c.log
change_rec_log -f./change_oper.cfg -k1 -i1 -xI_C_DATA_RECORD_OPER_YEAR_1 -oI_C_DATA_RECORD_OPER_YEAR_1 -u$login_w -p$passwd_w >$bin/log/change_oper_year_1_1.log 2> $bin/log/change_oper_year_1_2.log
change_rec_log -f./change_oper.cfg -k1 -i1 -xI_C_DATA_RECORD_OPER_YEAR_2 -oI_C_DATA_RECORD_OPER_YEAR_2 -u$login_w -p$passwd_w >$bin/log/change_oper_year_2_1.log 2> $bin/log/change_oper_year_2_2.log
change_rec_log -f./change_oper.cfg -k1 -i1 -xI_C_DATA_RECORD_OPER_YEAR_3 -oI_C_DATA_RECORD_OPER_YEAR_3 -u$login_w -p$passwd_w >$bin/log/change_oper_year_3_1.log 2> $bin/log/change_oper_year_3_2.log

echo "Vypocet aggreg. udaju z operativnich dat:       " `date` >> $bin/go_daily_c.log
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_3 -xi_c_aggreg_process -g./aggreg_oper3.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_3_1.log > $bin/log/aggreg_3_2.log &
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_2 -xi_c_aggreg_process -g./aggreg_oper2.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_2_1.log > $bin/log/aggreg_2_2.log &
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_1 -xi_c_aggreg_process -g./aggreg_oper1.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_1_1.log > $bin/log/aggreg_1_2.log &
wait

echo "Vypocet aggreg. udaju z operativnich dat - opr: " `date` >> $bin/go_daily_c.log
# Pustim to jeste jednou pro pripad, ze vypocet nektere registrace padl.
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_3 -xi_c_aggreg_process -g./aggreg_oper3.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_3_1a.log > $bin/log/aggreg_3_2a.log
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_2 -xi_c_aggreg_process -g./aggreg_oper2.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_2_1a.log > $bin/log/aggreg_2_2a.log
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_1 -xi_c_aggreg_process -g./aggreg_oper1.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_1_1a.log > $bin/log/aggreg_1_2a.log


# Reseni pro pocitani agregovanych udaju od roku 2019 - denni prumery od 00:00
echo "Setrepani i_c_data_record_oper_1_new az 3_new:  " `date` >> $bin/go_daily_c.log
change_rec_log -f./change_oper.cfg -k1 -i1 -xI_C_DATA_RECORD_OPER_YEAR_1NEW -oI_C_DATA_RECORD_OPER_YEAR_1NEW -u$login_w -p$passwd_w >$bin/log/change_oper_year_1_1_new.log 2> $bin/log/change_oper_year_1_2_new.log
change_rec_log -f./change_oper.cfg -k1 -i1 -xI_C_DATA_RECORD_OPER_YEAR_2NEW -oI_C_DATA_RECORD_OPER_YEAR_2NEW -u$login_w -p$passwd_w >$bin/log/change_oper_year_2_1_new.log 2> $bin/log/change_oper_year_2_2_new.log
change_rec_log -f./change_oper.cfg -k1 -i1 -xI_C_DATA_RECORD_OPER_YEAR_3NEW -oI_C_DATA_RECORD_OPER_YEAR_3NEW -u$login_w -p$passwd_w >$bin/log/change_oper_year_3_1_new.log 2> $bin/log/change_oper_year_3_2_new.log
change_rec_log -f./change_oper.cfg -k1 -i1 -xI_C_DATA_RECORD_OPER_INDEX     -oI_C_DATA_RECORD_OPER_INDEX     -u$login_w -p$passwd_w >$bin/log/change_oper_year_4_1_new.log 2> $bin/log/change_oper_year_4_2_new.log

echo "Vypocet aggreg. udaju z operativnich dat new:   " `date` >> $bin/go_daily_c.log
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_3new -xi_c_aggreg_process_new -g./aggreg_oper3_new.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_3_1_new.log > $bin/log/aggreg_3_2_new.log &
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_2new -xi_c_aggreg_process_new -g./aggreg_oper2_new.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_2_1_new.log > $bin/log/aggreg_2_2_new.log &
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_1new -xi_c_aggreg_process_new -g./aggreg_oper1_new.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_1_1_new.log > $bin/log/aggreg_1_2_new.log &
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_index     -xi_c_aggreg_process_new -g./aggreg_oper4_new.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_4_1_new.log > $bin/log/aggreg_4_2_new.log &

wait

#rm $bin/log/aggreg_1_2_new.log
#rm $bin/log/aggreg_2_1_new.log
#rm $bin/log/aggreg_2_2_new.log
#rm $bin/log/aggreg_2_2_new_a.log
#rm $bin/log/aggreg_3_2_new.log

echo "Vypocet aggreg. udaju z operativnich dat new o: " `date` >> $bin/go_daily_c.log
# Pustim to jeste jednou pro pripad, ze vypocet nektere registrace padl.
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_3new -xi_c_aggreg_process_new -g./aggreg_oper3_new.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_3_1_new_a.log > $bin/log/aggreg_3_2_new_a.log
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_2new -xi_c_aggreg_process_new -g./aggreg_oper2_new.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_2_1_new_a.log > $bin/log/aggreg_2_2_new_a.log
aggreg_master -f./aggreg_oper.cfg -k1 -i1 -r1 -l3 -ti_c_data_record_oper_year_1new -xi_c_aggreg_process_new -g./aggreg_oper1_new.log -w2 -v2 -s1,2 -u$login_w -p$passwd_w 2> $bin/log/aggreg_1_1_new_a.log > $bin/log/aggreg_1_2_new_a.log

rm $bin/log/aggreg_1_2_new.log
rm $bin/log/aggreg_2_1_new.log
rm $bin/log/aggreg_2_2_new.log
rm $bin/log/aggreg_2_2_new_a.log
rm $bin/log/aggreg_3_2_new.log


echo "Nalezeni druhy vyrob out of order:              " `date` >> $bin/go_daily_c.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/production_out_of_order2.log -demission.production_out_of_order -g"'1'" -u$login_w -p$passwd_w -k1 >$bin/log/production_out_of_order_1.log 2> $bin/log/production_out_of_order_3.log

echo "Konec:                                          " `date` >> $bin/go_daily_c.log