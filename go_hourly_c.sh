. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`


echo "Priprava dat pro CT (pani Mikova)               " `date` > $bin/go_hourly_c.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_ceska_televize_pm10.log -sgo_ceska_televize_pm10.sql -u$login_w -p$passwd_w -k1  >$bin/log/go_ceska_televize_pm10_1.log 2> $bin/log/go_ceska_televize_pm10_2.log
cat /4USERS/caqr/pollution/export_Ceska_Televize/PM10_hourly_data.txt>>/4USERS/caqr/pollution/export_Ceska_Televize/PM10_hourly_description.txt
cp /4USERS/caqr/pollution/export_Ceska_Televize/PM10_hourly_description.txt /4USERS/caqr/pollution/export_Ceska_Televize/PM10_hourly_data.txt
chmod 666 /4USERS/caqr/pollution/export_Ceska_Televize/PM10_hourly_data.txt
data_pro_CT.ftp >>$bin/log/data_pro_CT_1.log 2>>$bin/log/data_pro_CT_2.log
#cp /4USERS/caqr/pollution/export_Ceska_Televize/PM10_hourly_data.txt /export/home/provoz/mbhome/mbs.ftp


echo "Prehrani oprav op. dat 1x za hodiny dnes a vcera" `date` >>$bin/go_hourly_c.log
go_hourly_2.sh /export/home/provoz/bin/iso99opr.d /4USERS/caqr/pollution/data_oper/tmp/hourly/repair /4USERS/caqr/pollution/data_oper/archive/hourly/repair


echo "Konec:                                          " `date` >> $bin/go_hourly_c.log