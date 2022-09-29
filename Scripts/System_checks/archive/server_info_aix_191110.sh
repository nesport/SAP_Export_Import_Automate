rm -rf /tmp/$(hostname)_server_info.txt
echo "
---oslevel -s---" >> /tmp/$(hostname)_server_info.txt
oslevel -s  >> /tmp/$(hostname)_server_info.txt
echo "
---prtconf | head -n 28---" >> /tmp/$(hostname)_server_info.txt
prtconf | head -n 28 >> /tmp/$(hostname)_server_info.txt
echo "
---mount---" >>/tmp/$(hostname)_server_info.txt
mount | awk '{printf "%-28s %-20s %-10s /%s\n",$2,$1,$3,$7,$4,$5,$5,$7}'>> /tmp/$(hostname)_server_info.txt
echo "
---df-g---" >> /tmp/$(hostname)_server_info.txt
df -g | awk '{printf "%-25s %-20s %6s %8s %7s %9s %s\n",$7,$1,$2,$3,$4,$5,$6}'>> /tmp/$(hostname)_server_info.txt
echo "
---ls-la /---" >> /tmp/$(hostname)_server_info.txt
ls -la / | grep '^d' | awk '{printf "%-20s %-12s %10s %s\n",$9,$1,$3,$4}' >> /tmp/$(hostname)_server_info.txt
echo "
---id <sidadm>---" >>/tmp/$(hostname)_server_info.txt
id er0adm >> /tmp/$(hostname)_server_info.txt