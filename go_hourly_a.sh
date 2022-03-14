. $HOME/env_ora_caqr.cfg

cd
cp .netrc_main .netrc

bin=/4USERS/caqr/bin
cd $bin

login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`


MMBegin=`date "+%M"`

#cp_iso.sh
#cp_tozr.sh
echo "Nahrani operativnich dat:                         " `date` > $bin/go_hourly_a.log
$bin/go_hourly_1.sh /export/home/provoz/bin/iso99.d /4USERS/caqr/pollution/data_oper/tmp/hourly/routine /4USERS/caqr/pollution/data_oper/archive/hourly/routine

echo "Nahrani polskych operativnich dat:                " `date` >> $bin/go_hourly_a.log
$bin/go_poland_hourly.sh

echo "Nahrani rakouskych operativnich dat:              " `date` >> $bin/go_hourly_a.log
$bin/go_oster_hourly.sh

echo "Nahrani slovenskych operativnich dat:             " `date` >> $bin/go_hourly_a.log
$bin/go_slovak_hourly.sh

MM=`date "+%M"`
if [ $MM -lt 40 ] 
then
  cd $bin
  echo "Generovani pro AIM SVRS:                          " `date` >> $bin/go_hourly_a.log
  sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_svrs.log -dhourly_index_svrs -g"0"  -u$login_w -p$passwd_w -k1 >$bin/log/hourly_index_svrs_1.log 2> $bin/log/hourly_index_svrs_2.log
  
  echo "Generovani pro AIM SVRS do XHTML:                 " `date` >> $bin/go_hourly_a.log
  cd $bin
  cd isko_web_generator
  go_svrs.sh              >$bin/log/go_svrs_1.log 2> $bin/log/go_svrs_2.log
fi

echo "Generovani ozonovych hodnot z mapgeneratoru:      " `date` >> $bin/go_hourly_a.log
cd $bin/isko_map_generator
go_o3.sh

echo "Generovani hodinoveho indexu znecisteni v sql:    " `date` >> $bin/go_hourly_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_1.log -dhourly_index -g"0"  -u$login_w -p$passwd_w -k1  >$bin/log/hourly_index_1.log 2> $bin/log/hourly_index_2.log

echo "Generovani 3hodinoveho indexu znecisteni v sql:   " `date` >> $bin/go_hourly_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/index_3hour_1.log -dindex_3hour -g"0"  -u$login_w -p$passwd_w -k1  >$bin/log/index_3hour_1.log 2> $bin/log/index_3hour_2.log

if [ $MMBegin -lt 45 ] 
then
  cd $bin
  echo "Generovani pro hodinoveho bulletinu:              " `date` >> $bin/go_hourly_a.log
  sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_bulletin.log -dhourly_index_bulletin -g"0,'/4USERS/caqr/pollution/bulletiny_oco_operativa/'"  -u$login_w -p$passwd_w -k1 >$bin/log/hourly_index_bulletin_1.log 2> $bin/log/hourly_index_bulletin_2.log
  
  echo "Generovani pro hodinove bulletinu SQL_1           " `date` >> $bin/go_hourly_a.log
  cd $bin
  sqlrun -f./sqlrun.cfg -r1 -l$bin/log/hourly_index_bulletin_sql_0.log -sgo_hourly_bulletin_to_script.sql -u$login_w -p$passwd_w -k1  >$bin/log/hourly_index_bulletin_sql_1.log 2> $bin/log/hourly_index_bulletin_sql_2.log
  echo "Generovani pro hodinove bulletinu SQL_2           " `date` >> $bin/go_hourly_a.log
  cd $bin
  sqlrun -f./sqlrun.cfg -r1 -l$bin/log/hourly_index_bulletin_sql_3.log -sgo_hourly_bulletin_to_file.sql -u$login_w -p$passwd_w -k1  >$bin/log/hourly_index_bulletin_sql_4.log 2> $bin/log/hourly_index_bulletin_sql_4.log
fi


echo "Generovani pro klikaci mapu na portale:           " `date` >> $bin/go_hourly_a.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_slide.log -dhourly_index_slide -g"0"  -u$login_w -p$passwd_w -k1 >$bin/log/hourly_index_slide_1.log 2> $bin/log/hourly_index_slide_2.log


echo "Generovani pro klikaci mapu na portale typ 3h:    " `date` >> $bin/go_hourly_a.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/index_3hour_slide.log -dindex_3hour_slide -g"0"  -u$login_w -p$passwd_w -k1 >$bin/log/index_3hour_slide_1.log 2> $bin/log/index_3hour_slide_2.log

echo "Generovani hodinoveho indexu znecisteni do xhtml: " `date` >> $bin/go_hourly_a.log
cd $bin
cd isko_web_generator
go_tab_index.sh          >$bin/log/go_tab_index_1.log 2> $bin/log/go_tab_index_2.log

echo "Generovani 3hodinoveho indexu znecisteni do xhtml:" `date` >> $bin/go_hourly_a.log
cd $bin
cd isko_web_generator
go_tab_index_new.sh      >$bin/log/go_tab_index_3h_1.log 2> $bin/log/go_tab_index_3h_2.log

echo "Generovani pro Android:                           " `date` >> $bin/go_hourly_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/android_export_hourly.log -dandroid_export_hourly -g"1"  -u$login_w -p$passwd_w -k1 >$bin/log/android_export_hourly_1.log 2> $bin/log/android_export_hourly_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_android.log -sgo_hourly_android.sql -u$login_w -p$passwd_w -k1  >$bin/log/go_hourly_android_1.log 2> $bin/log/go_hourly_android_2.log
cd $bin/idea_common_util
java -Dcron=true -jar IdeaCommonLib.jar /C /4USERS/caqr/pollution/export_Android/Android_hourly.xml /4USERS/caqr/pollution/export_Android/Android_hourly_UTF8.xml windows-1250 UTF-8
cp /4USERS/caqr/pollution/export_Android/Android_hourly_UTF8.xml /4USERS/caqr/pollution/export_Android/Android_hourly.xml

echo "Generovani hodinoveho alarmu znecisteni v sql:    " `date` >> $bin/go_hourly_a.log
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/alarm_value_1.log -dalarm_value -g"1"  -u$login_w -p$passwd_w -k1  >$bin/log/alarm_value_1_1.log 2> $bin/log/alarm_value_1_2.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/alarm_value_2.log -dalarm_value -g"2"  -u$login_w -p$passwd_w -k1  >$bin/log/alarm_value_2_1.log 2> $bin/log/alarm_value_2_2.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/alarm_value_3.log -dalarm_value -g"3"  -u$login_w -p$passwd_w -k1  >$bin/log/alarm_value_3_1.log 2> $bin/log/alarm_value_3_2.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/alarm_value_4.log -dalarm_value -g"4"  -u$login_w -p$passwd_w -k1  >$bin/log/alarm_value_4_1.log 2> $bin/log/alarm_value_4_2.log
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/alarm_send.log -dalarm_send -g"0"  -u$login_w -p$passwd_w -k1      >$bin/log/alarm_send_1.log 2> $bin/log/alarm_send_2.log
cd $bin
cd isko_alarm_sender
go_email.sh              >$bin/log/go_email_1.log 2> $bin/log/go_email_2.log


cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_export_01.log -dhourly_index_export_01 -g"1"  -u$login_w -p$passwd_w -k1     >$bin/log/hourly_index_export_01_1.log 2> $bin/log/hourly_index_export_01_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_index_export_01.log -sgo_hourly_index_export_01.sql -u$login_w -p$passwd_w -k1  >$bin/log/go_hourly_index_export_01_1.log 2> $bin/log/go_hourly_index_export_01_2.log
cd $bin/idea_common_util
java -Dcron=true -jar IdeaCommonLib.jar /C /4USERS/caqr/pollution/export_Android/AIMdata_hourly.xml /4USERS/caqr/pollution/export_Android/AIMdata_hourly_UTF8.xml windows-1250 UTF-8
cp /4USERS/caqr/pollution/export_Android/AIMdata_hourly_UTF8.xml /4USERS/caqr/pollution/export_Android/AIMdata_hourly.xml
cd $bin
hourly_index_export_01.ftp >$bin/log/hourly_index_export_01_ftp_1.log 2>$bin/log/hourly_index_export_01_ftp_2.log

cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_export_02.log -dhourly_index_export_02 -g"1"  -u$login_w -p$passwd_w -k1     >$bin/log/hourly_index_export_02_1.log 2> $bin/log/hourly_index_export_02_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_index_export_02.log -sgo_hourly_index_export_02.sql -u$login_w -p$passwd_w -k1  >$bin/log/go_hourly_index_export_02_1.log 2> $bin/log/go_hourly_index_export_02_2.log
cd $bin/idea_common_util
java -Dcron=true -jar IdeaCommonLib.jar /C /4USERS/caqr/pollution/export_Android/AIMdata_hourly_POL.xml /4USERS/caqr/pollution/export_Android/AIMdata_hourly_POL_UTF8.xml windows-1250 UTF-8
cp /4USERS/caqr/pollution/export_Android/AIMdata_hourly_POL_UTF8.xml /4USERS/caqr/pollution/export_Android/AIMdata_hourly_POL.xml
cd $bin
hourly_index_export_02.ftp >$bin/log/hourly_index_export_02_ftp_1.log 2>$bin/log/hourly_index_export_02_ftp_2.log


cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/hourly_index_export_03.log -dhourly_index_export_03 -g"1"  -u$login_w -p$passwd_w -k1     >$bin/log/hourly_index_export_03_1.log 2> $bin/log/hourly_index_export_03_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_index_export_03.log -sgo_hourly_index_export_03.sql -u$login_w -p$passwd_w -k1  >$bin/log/go_hourly_index_export_03_1.log 2> $bin/log/go_hourly_index_export_03_2.log
cd $bin/idea_common_util
java -Dcron=true -jar IdeaCommonLib.jar /C /4USERS/caqr/pollution/export_Android/AIMdata_hourly_data.xml /4USERS/caqr/pollution/export_Android/AIMdata_hourly_data_UTF8.xml windows-1250 UTF-8
cp /4USERS/caqr/pollution/export_Android/AIMdata_hourly_data_UTF8.xml /4USERS/caqr/pollution/export_Android/AIMdata_hourly_data.xml
cd $bin
hourly_index_export_03.ftp >$bin/log/hourly_index_export_03_ftp_1.log 2>$bin/log/hourly_index_export_03_ftp_2.log #  2021-09-15 po diskuzi s panem Pokornym - musi to byt spousteno pres ftp


#cp_xml.sh

echo "Generovani pro Android_3:                         " `date` >> $bin/go_hourly_a.log
cd
cp .netrc_2 .netrc
cd $bin
sqlrun -f./sqlrun.cfg -r2 -l$bin/log/android_export_hourly_3.log -dandroid_export_hourly_3 -g"1"  -u$login_w -p$passwd_w -k1   >$bin/log/android_export_hourly_3_1.log 2> $bin/log/android_export_hourly_3_2.log
sqlrun -f./sqlrun.cfg -r1 -l$bin/log/go_hourly_android_3.log -sgo_hourly_android_3.sql -u$login_w -p$passwd_w -k1              >$bin/log/go_hourly_android_3_1.log 2> $bin/log/go_hourly_android_3_2.log
cd $bin/idea_common_util
java -Dcron=true -jar IdeaCommonLib.jar /C /4USERS/caqr/pollution/export_Android/Ostrava_hourly.xml /4USERS/caqr/pollution/export_Android/Ostrava_hourly_UTF8.xml windows-1250 UTF-8
cp /4USERS/caqr/pollution/export_Android/Ostrava_hourly_UTF8.xml /4USERS/caqr/pollution/export_Android/Ostrava_hourly.xml
cd $bin
hourly_export_android_3.ftp > $bin/log/hourly_export_android_3_1.log 2> $bin/log/hourly_export_android_3_2.log #  2021-09-15 po diskuzi s panem Pokornym - musi to byt spousteno pres ftp
cd
cp .netrc_main .netrc

echo "Vlozeni signalu upozorneni nebo regulace do DB    " `date` >> $bin/go_hourly_a.log
cd $bin
go_signal.sh > $bin/log/go_signal_1.log 2> $bin/log/go_signal_2.log

echo "Konec:                                            " `date` >> $bin/go_hourly_a.log

cd $bin/log
/4USERS/caqr/bin/mail_error.sh nov@idea-envi.cz ORA- "Error from pr_provoz"
/4USERS/caqr/bin/mail_error.sh nov@idea-envi.cz Error "Error from pr_provoz"

exit 0