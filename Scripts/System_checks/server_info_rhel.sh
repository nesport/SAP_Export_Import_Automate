rm -rf /tmp/$(hostname)_server_info.txt
echo "---/etc/redhat-release---" >> /tmp/$(hostname)_server_info.txt
cat /etc/redhat-release >> /tmp/$(hostname)_server_info.txt
echo "---cat /proc/meminfo---" >> /tmp/$(hostname)_server_info.txt
cat /proc/meminfo >> /tmp/$(hostname)_server_info.txt
echo "---lscpu---" >> /tmp/$(hostname)_server_info.txt
lscpu >> /tmp/$(hostname)_server_info.txt
echo "---/sbin/ifconfig---" >> /tmp/$(hostname)_server_info.txt
/sbin/ifconfig >> /tmp/$(hostname)_server_info.txt
echo "---netstat -l -tnp---" >> /tmp/$(hostname)_server_info.txt
netstat -l -tnp >> /tmp/$(hostname)_server_info.txt
echo "---mount---" >> /tmp/$(hostname)_server_info.txt
mount >> /tmp/$(hostname)_server_info.txt
echo "---df-p---" >> /tmp/$(hostname)_server_info.txt
#вывод с указанием процента свободного места
#df -Ph | awk '{printf "%-35s %-8s %s\n",$6,$2,$5}'| while read dir rest; do echo -e $dir ' \t '$rest' \t '`ls -ld $dir| awk -F " " '{print $1, $3, $4}' `; done >> /tmp/$(hostname)_server_info.txt
#вывод без указани€ процента свободного места
df -Ph | awk '{printf "%-35s %s\n",$6,$2}'| while read dir rest; do echo -e $dir ' \t '$rest' \t '`ls -ld $dir| awk -F " " '{print $1, $3, $4}' `; done >> /tmp/$(hostname)_server_info.txt
echo "---ls-la---" >> /tmp/$(hostname)_server_info.txt
ls -la / | grep '^d' | awk '{printf "%-20s %-12s %10s %s\n",$9,$1,$3,$4}' >> /tmp/$(hostname)_server_info.txt
echo "---SIDs in /usr/sap/---" >> /tmp/$(hostname)_server_info.txt
ls /usr/sap/ | grep -x '.\{3,3\}' | grep -v "[a-z]" >> /tmp/$(hostname)_server_info.txt
echo "---cat /etc/passwd  grep adm|ora---" >> /tmp/$(hostname)_server_info.txt
cat /etc/passwd | grep adm >> /tmp/$(hostname)_server_info.txt
cat /etc/passwd | grep ora >> /tmp/$(hostname)_server_info.txt
echo "---cat /etc/group grep sapsys|dba---" >> /tmp/$(hostname)_server_info.txt
cat /etc/group | grep sapsys >> /tmp/$(hostname)_server_info.txt
cat /etc/group | grep sapinst >> /tmp/$(hostname)_server_info.txt
cat /etc/group | grep dba >> /tmp/$(hostname)_server_info.txt