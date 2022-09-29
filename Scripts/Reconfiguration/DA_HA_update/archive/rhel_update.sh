COMMAND2="/usr/sap/hostctrl/exe/saphostexec pf=/usr/sap/hostctrl/exe/host_profile -stop"
eval '$COMMAND2'
runuser -l  da1adm -c 'stopsap'
# wait
scp scp@192.168.58.82:/share/pub/basis/Systems_export/DA_RHEL/DA1_RHEL.tar /tmp/
rm -rf /usr/sap/hostctrl/*
rm -rf /home/da1adm/*
rm -rf /usr/sap/DA1/SMDA98
rm -rf /usr/sap/DA1/SYS/profile/*
rm -rf /tmp/.sapstartsrv*
tar -xvf /tmp/DA1_RHEL.tar -C /
chown --from=212:sapsys da1adm:sapsys -cR /usr/sap/DA1/
chown --from=212:sapsys da1adm:sapsys -cR /home/da1adm/
mv /usr/sap/DA1/SYS/profile/DA1_SMDA97_pd1ap01 /usr/sap/DA1/SYS/profile/DA1_SMDA97_$(hostname -s)
mv /home/da1adm/.j2eeenv_pd1ap01.csh /home/da1adm/.j2eeenv_$(hostname -s).csh
mv /home/da1adm/.j2eeenv_pd1ap01.sh /home/da1adm/.j2eeenv_$(hostname -s).sh
mv /home/da1adm/.sapenv_pd1ap01.csh /home/da1adm/.sapenv_$(hostname -s).csh
mv /home/da1adm/.sapenv_pd1ap01.sh /home/da1adm/.sapenv_$(hostname -s).sh
mv /home/da1adm/.sapsrc_pd1ap01.csh /home/da1adm/.sapsrc_$(hostname -s).csh
mv /home/da1adm/.sapsrc_pd1ap01.sh /home/da1adm/.sapsrc_$(hostname -s).sh
sed -i "s/pd1ap01/$(hostname -s)/g" /usr/sap/sapservices
sed -i "s/SMDA98/SMDA97/g" /usr/sap/sapservices
sed -i "s/pd1ap01/$(hostname -s)/g" /usr/sap/DA1/SYS/profile/DA1_SMDA97_$(hostname -s)
sed -i "s/pd1ap01/$(hostname -s)/g" /usr/sap/DA1/SMDA97/SMDAgent/configuration/runtime.properties
sed -i "s/pd1ap01/$(hostname -s)/g" /usr/sap/DA1/SMDA97/SMDAgent/configuration/installationinfo.properties
sed -i "s/pd1ap01/$(hostname -s)/g" /usr/sap/DA1/SMDA97/SMDAgent/applications.config/com.sap.smd.agent.application.wilyhost/IntroscopeSapAgent.profile
COMMAND1="/usr/sap/hostctrl/exe/saphostexec  pf=/usr/sap/hostctrl/exe/host_profile -start"
eval '$COMMAND1'
runuser -l  da1adm -c 'startsap'