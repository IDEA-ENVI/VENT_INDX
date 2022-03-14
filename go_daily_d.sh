. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`

echo "Vyhledani registraci bez dat:                   " `date` > $bin/go_daily_d.log
sqlrun -f./sqlrun.cfg -r2 -lmissing_data_registration.log -dmissing_data_registration -g"0" -u$login_w -p$passwd_w -k1
echo "Konec:                                          " `date` >> $bin/go_daily_d.log