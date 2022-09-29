#!/usr/bin/bash

PRINT_OK="[  \033[0;32mOK\033[0;37m  ]"
PRINT_ERROR="[\033[0;31mERROR\033[0;37m ]"
TMPF=/tmp/check_ot.tmp

check_str_equal() {
if [ x"$1" = x"$2" ]
  then echo -e $1 "$PRINT_OK"
  else echo -e $1 / $2 "$PRINT_ERROR"
fi
}

check_num_equal() {
if [ "$1" -eq "$2" ]
  then echo -e "$PRINT_OK"
  else echo -e "$PRINT_ERROR"
fi
}

check_num_gt() {
if [ "$1" -gt "$2" ]
  then echo -e "$PRINT_OK"
  else echo -e "$PRINT_ERROR"
fi
}

check_num_ge() {
if [ "$1" -ge "$2" ]
  then echo -e "$PRINT_OK"
  else echo -e "$PRINT_ERROR"
fi
}


echo -ne "1.1 Checking locale...   "
fileset=`locale -a | grep de_DE | wc -l`
check_num_ge "$fileset" 1

echo -ne "1.2 Checking file set consistent...   "
fileset=`lppchk -v 2>&1 | grep "not installed" | tee $TMPF | wc -l`
check_num_equal "$fileset" 0
cat  $TMPF

echo -ne "1.3 Getting OS level...   "
oslevel -s

echo -ne "1.4 Checking XL C++ runtime ver >=12104...   "
parc=`lslpp -L | grep xlC | grep "6.1" | awk '{print($2)}' | awk -F\. '{print($1$2$3$4)}'`
echo -ne $parc
check_num_ge $parc 12104

echo -ne "1.5 Checking swap size >20480MB...   "
swaps=`lsps -a | grep hdisk | awk '{print($4)}' | sed 's/[A-Z]//g'`
ss=`for i in "$swaps"; do echo -ne $i" "; done | sed 's/ $//g' | sed 's/ /+/g'`
s1=$(echo $ss | bc)
echo -ne "$s1"
#swap_size=`lsps -a | grep hd6 | awk '{print($4)}'| sed 's/[A-Z]//g'`
check_num_gt $s1 20480

echo "1.6 Checking AIX boot variable...   "
echo -ne "1.6.1 Checking GETTOD_ADJ_MONOTONIC=1 in /etc/environment...   "
par1=`grep "^GETTOD_ADJ_MONOTONIC=1$" /etc/environment | wc -l`
check_num_equal $par1 1

echo -ne "1.6.2 Check maxuproc >= 16384...   "
parproc=`lsattr -El sys0 -a maxuproc | awk '{print($2)}'`
echo -ne $parproc
check_num_ge $parproc 16384

echo "1.6.3 Checking IO prefomance..."
echo -ne "    minpout...   "
mp=`lsattr -El sys0 | grep pout | grep min | awk '{print($2)}'`
check_str_equal $mp 4096
echo -ne "    maxpout...   "
mp=`lsattr -El sys0 | grep pout | grep max | awk '{print($2)}'`
check_str_equal $mp 8193

echo "1.6.4 Checking memory params"
echo -ne "    minperm%...   "
par=`vmo -o minperm% | awk '{print($3)}'`
check_str_equal $par 3

echo -ne "    maxperm%...   "
par=`vmo -o maxperm% | awk '{print($3)}'`
check_str_equal $par 90

echo -ne "    maxclient%...   "
par=`vmo -o maxclient% | awk '{print($3)}'`
check_str_equal $par 90

echo -ne "    strict_maxclient...   "
par=`vmo -o strict_maxclient | awk '{print($3)}'`
check_str_equal $par 1

echo -ne "    strict_maxperm...   "
par=`vmo -o strict_maxperm | awk '{print($3)}'`
check_str_equal $par 0

echo -ne "    minfree...   "
par=`vmo -o minfree | awk '{print($3)}'`
check_str_equal $par 960

echo -ne "    maxfree...   "
par=`vmo -o maxfree | awk '{print($3)}'`
check_str_equal $par 1088

echo "1.6.5 Check limits...   "
cat >> /tmp/templimits << EOF
time(seconds)        unlimited
file(blocks)         unlimited
data(kbytes)         unlimited
stack(kbytes)        unlimited
memory(kbytes)       unlimited
coredump(blocks)     2097151
nofiles(descriptors) 32000
threads(per process) unlimited
processes(per user)  unlimited
EOF

for i in $(awk -F ":" '{print $1}' /etc/passwd | egrep "(^ora|[a-z0-9]adm$)" )
do
su $i "-c csh -c \"ulimit -a > /tmp/templimits_on\""
echo -n "    user $i    "
par=`diff /tmp/templimits /tmp/templimits_on | wc -l`
if [ "$par" -eq 0 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR" Please check file /etc/security/limits
  diff /tmp/templimits /tmp/templimits_on
fi
rm -rf /tmp/templimits_on
done

rm -rf /tmp/templimits

echo -ne "1.7.1 Checking if IOCP available...   "
par=`lsdev | grep iocp | grep Available | wc -l`
check_num_equal $par 1
lsdev | grep iocp

echo "1.7.2 Checking installed filesets:"
echo -ne "    bos.adt.base...   "
par=`lslpp -l bos.adt.base | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "    bos.adt.lib...   "
par=`lslpp -l bos.adt.lib | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "    bos.adt.libm...   "
par=`lslpp -l bos.adt.libm | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "    bos.perf.libperfstat...   "
par=`lslpp -l bos.perf.libperfstat | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "    bos.perf.perfstat...   "
par=`lslpp -l bos.perf.perfstat | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "    bos.perf.proctools...   "
par=`lslpp -l bos.perf.proctools | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "    rsync...   "
par=`lslpp -L all rsync 2>&1 | grep " C " | grep -v Com | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi


echo -ne "1.8.1 Checking file permission...   "
par=`ls -l /etc/environment | awk '{print($1)}'`
st="-rw-r--r--"
if [ "$par" == "$st" ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		"
  ls -l /etc/environment
fi

echo -ne "1.8.2 Checking timezone...   "
par=`echo $TZ`
check_str_equal  "$par" "Europe/Moscow"

echo "2.1 check disk multipathing...   "
MINPATH=$(lspath | awk '/^Enabled/ {print $2 }' | sort | uniq -c | awk '{ print $1}' | sort -n -k1 | head -1)
echo -n "    min path num: $MINPATH    "
check_num_gt $MINPATH 1
FPATH=$( lspath | grep -c -v Enabled) 
echo -n "    path not enabled: $FPATH    "
check_num_equal $FPATH 0


echo -e "2.2 Check misc programs...  "
for i in nfsd ssh sshpass ansible python Xorg rsync
do
echo -ne "    $i    " 
PRG=$(which $i 2>/dev/null)
if [ -n "$PRG" ]
 then
  check_str_equal "$PRG" "$PRG"
 else
  check_str_equal "not found" "$i"
 fi
done

echo -ne "2.12 Checking sendmail configuration...   "
par=$(grep -c  ^Dj$(hostname).x5.ru$ /etc/mail/sendmail.cf )
if [ "$par" -eq 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR""              "
fi


echo -ne "2.13.1 Checking /etc/resolv.conf ...   "
par=$(egrep -c "^(search +sap.x5.ru x5.ru|nameserver +192.168.129.5|nameserver +192.168.129.254)$"  /etc/resolv.conf )
check_num_equal $par 3

echo -ne "2.13.2 Checking  /etc/netsvc.conf...   "
par=$(egrep -c  ^hosts\ \+\=\ local\,\ \+bind /etc/netsvc.conf)
check_num_equal $par 1

echo -ne "2.15.1 Checking ntpd start params...   "
par=`egrep '^start /usr/sbin/xntpd "\\$src_running" "-x"$' /etc/rc.tcpip | wc -l`
check_num_equal $par 1

echo -ne "2.15.2 Checking running ntpd params...   "
par=`ps -ef | grep ntp | grep -- "-x" | wc -l`
check_num_equal $par 1

echo -ne "2.15.3 Checking ntpd servers...   "
#par=`egrep "192.168.124.134|192.168.129.17" /etc/ntp.conf | wc -l`
par=`egrep  "^server +(192.168.124.134 +prefer|192.168.129.17)$" /etc/ntp.conf | wc -l`
check_num_equal $par 2


echo "2.16 checking password policy...   "
echo -n "    histexpire.. "
check_str_equal $(lssec -f /etc/security/user -s default -a histexpire | awk -F = '{ print $2 }') 26
echo -n "    histsize..  "
check_str_equal $(lssec -f /etc/security/user -s default -a histsize | awk -F = '{ print $2 }') 4
echo -n "    minalpha..  "
check_str_equal $(lssec -f /etc/security/user -s default -a minalpha | awk -F = '{ print $2 }') 1
echo -n "    minother..  "
check_str_equal $(lssec -f /etc/security/user -s default -a minother | awk -F = '{ print $2 }') 1
echo -n "    minlen..  "
check_str_equal $(lssec -f /etc/security/user -s default -a minlen | awk -F = '{ print $2 }') 12
echo -n "    mindiff..  "
check_str_equal $(lssec -f /etc/security/user -s default -a mindiff | awk -F = '{ print $2 }') 4

echo -ne "2.17 checking hash algorithm...   "
algo=$(egrep "pwd_algorithm +=" /etc/security/login.cfg | awk '{ print $3 }')
check_str_equal $algo ssha512

echo -ne "2.18 removing empty crontabs...   "
cd /var/spool/cron/crontabs
for file in *; do
lines=`grep -Ev '^[ \t]*#' $file | wc -l | sed 's/ //g'`
if [ $lines -eq 0 ]; then
echo "Removing $file"
rm $file
fi
done
 
chgrp -R cron /var/spool/cron/crontabs
chmod -R o= /var/spool/cron/crontabs
chmod 770 /var/spool/cron/crontabs
echo -e "$PRINT_OK"

echo -ne "2.19 fixing /etc/passwd ...   "
pwdck -y ALL
echo -e "$PRINT_OK"

