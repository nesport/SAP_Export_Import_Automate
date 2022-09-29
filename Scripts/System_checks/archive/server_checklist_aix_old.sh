#!/usr/bin/bash

PRINT_OK="[  \033[0;32mOK\033[0;37m  ]"
PRINT_ERROR="[\033[0;31mERROR\033[0;37m ]"

echo -ne "1.1 Checking locale...   "
fileset=`locale | grep de_DE | wc -l`
if [ "$fileset" -ge 1 ]; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		"
  locale | grep LANG
fi

echo -ne "1.2 Checking file set consistent...   "
fileset=`lppchk -v 2>&1 | grep "not installed" | wc -l`
if [ "$fileset" -eq 0 ]; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi

echo -ne "1.3 Getting OS level...   "
oslevel -s

echo -ne "1.4 Checking XL C++ runtime...   "
parc=`lslpp -L | grep xlC | grep "6.1" | awk '{print($2)}' | awk -F\. '{print($1$2$3$4)}'`
if [ "$parc" -gt 12104 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi

echo -ne "1.5 Checking swap size...   "
swaps=`lsps -a | grep hdisk | awk '{print($4)}' | sed 's/[A-Z]//g'`
ss=`for i in "$swaps"; do echo -ne $i" "; done | sed 's/ $//g' | sed 's/ /+/g'`
s1=$(echo $ss | bc)
#echo "$s1"
#swap_size=`lsps -a | grep hd6 | awk '{print($4)}'| sed 's/[A-Z]//g'`
if [ "$s1" -gt 20480 ]; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR""		""$s1""MB"
fi

echo "1.6 Checking AIX boot variable...   "
echo -ne "1.6.1 Checking GETTOD_ADJ_MONOTONIC...   "
par1=`grep GETTOD_ADJ_MONOTONIC /etc/environment | wc -l`
if [ "$par1" -eq 0 ]; then
  echo -e "$PRINT_ERROR""		Variable is missing"
else
  par2=`grep GETTOD_ADJ_MONOTONIC /etc/environment | awk -F= '{print($2)}'`
  if [ "$par2" -eq 1 ] ; then
    echo -e "$PRINT_OK"
  else
    echo -ne "$PRINT_ERROR""		"
    grep GETTOD_ADJ_MONOTONIC /etc/environment
  fi
fi

echo -ne "1.6.2 Check maxuproc...   "
parproc=`lsattr -El sys0 -a maxuproc | awk '{print($2)}'`
if [ "$parproc" -ge 16384 ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$parproc"
fi

echo "1.6.3 Checking IO prefomance..."
echo -ne "minpout...   "
mp=`lsattr -El sys0 | grep pout | grep min | awk '{print($2)}'`
if [ "$mp" -eq 4096 ]; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$mp"
fi
echo -ne "maxpout...   "
mp=`lsattr -El sys0 | grep pout | grep max | awk '{print($2)}'`
if [ "$mp" -eq 8193 ]; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$mp"
fi

echo "1.6.4 Checking memory params"
echo -ne "minperm%...   "
par=`vmo -o minperm% | awk '{print($3)}'`
if [ "$par" -eq 3 ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi

echo -ne "maxperm%...   "
par=`vmo -o maxperm% | awk '{print($3)}'`
if [ "$par" -eq 90  ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi
echo -ne "maxclient%...   "
par=`vmo -o maxclient% | awk '{print($3)}'`
if [ "$par" -eq 90  ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi
echo -ne "strict_maxclient...   "
par=`vmo -o strict_maxclient | awk '{print($3)}'`
if [ "$par" -eq 1  ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi
echo -ne "strict_maxperm...   "
par=`vmo -o strict_maxperm | awk '{print($3)}'`
if [ "$par" -eq 0  ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi
echo -ne "minfree...   "
par=`vmo -o minfree | awk '{print($3)}'`
if [ "$par" -eq 960  ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi
echo -ne "maxfree...   "
par=`vmo -o maxfree | awk '{print($3)}'`
if [ "$par" -eq 1088  ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi

echo -ne "1.6.5 Check limits...   "
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

csh -c "ulimit -a" > /tmp/templimits_on
par=`diff /tmp/templimits /tmp/templimits_on | wc -l`
if [ "$par" -eq 0 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR" Please check file /etc/security/limits
fi
rm -rf /tmp/templimits
rm -rf /tmp/templimits_on

echo -ne "1.7.1 Checking IOCP...   "
par=`lsdev | grep iocp | grep Available | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		"
  lsdev | grep iocp
fi

echo "1.7.2 Checking installed filesets:"
echo -ne "bos.adt.base...   "
par=`lslpp -l bos.adt.base | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "bos.adt.lib...   "
par=`lslpp -l bos.adt.lib | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "bos.adt.libm...   "
par=`lslpp -l bos.adt.libm | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "bos.perf.libperfstat...   "
par=`lslpp -l bos.perf.libperfstat | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "bos.perf.perfstat...   "
par=`lslpp -l bos.perf.perfstat | grep COMMITTED | wc -l`
if [ "$par" -ge 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi
echo -ne "bos.perf.proctools...   "
par=`lslpp -l bos.perf.proctools | grep COMMITTED | wc -l`
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
if [ "$par" == "Europe/Moscow" ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		""$par"
fi


echo -ne "2.13 Checking hosts resolutions in /etc/netsvc.conf...   "
par=`grep hosts /etc/netsvc.conf | grep -v \# | wc -l`
if [ "$par" -eq 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		"
  grep hosts /etc/netsvc.conf | grep -v \#
  echo ""
fi

echo -ne "2.15.1 Checking ntpd start params...   "
par=`ps -ef | grep ntp | grep -- "-x" | wc -l`
if [ "$par" -eq 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -e "$PRINT_ERROR"
fi

echo -ne "2.15.2 Checking ntpd servers...   "
par=`egrep "192.168.124.134|192.168.129.17" /etc/ntp.conf | wc -l`
if [ "$par" -eq 1 ] ; then
  echo -e "$PRINT_OK"
else
  echo -ne "$PRINT_ERROR""		"
  grep server /etc/ntp.conf
fi
