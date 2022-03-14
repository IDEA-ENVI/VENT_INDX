. $HOME/env_ora_caqr.cfg

bin=/4USERS/caqr/bin

cd $bin
login_w=`sed -n '1p' ../.runner_w`
passwd_w=`sed -n '2p' ../.runner_w`



sqlrun -f./sqlrun.cfg -r2 -l$bin/log/vix_aggreg.log -dvix.vix_aggreg -g"'1'" -u$login_w -p$passwd_w -k1 >$bin/log/vix_aggreg_1.log 2> $bin/log/vix_aggreg_2.log

