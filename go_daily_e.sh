. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin
main_dir=/4USERS/caqr/pollution/export_coordinate

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`

echo "Zacatek ...                                     " `date` > $bin/go_daily_e.log

# generovani denniho snapshotu souradnic imisnich stanic
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/daily_coordinate.log -dpollution.export_coordinate -g"'$main_dir','pr-mw.chmi.cz','mobily_mapy'"  -u$login_w -p$passwd_w -k1 >$bin/log/daily_coordinate_1.log 2> $bin/log/daily_coordinate_2.log

echo "Spusteni sql scriptu                            " `date` >> $bin/go_daily_e.log
sqlrun -f./sqlrun.cfg -r1 -s$bin/go_export_coordinate.sql -l$bin/log/daily_coordinate_3.log -u$login_w -p$passwd_w -k1

chmod +x $main_dir/export_coordinate.ftp
chmod +x $main_dir/export_data.sh

echo "Spusteni sh scriptu                             " `date` >> $bin/go_daily_e.log
cd $main_dir
export_data.sh

export_coordinate.ftp

#rm -r *.csv >$bin/log/daily_coordinate_6.log

echo "Konec:                                          " `date` >> $bin/go_daily_e.log