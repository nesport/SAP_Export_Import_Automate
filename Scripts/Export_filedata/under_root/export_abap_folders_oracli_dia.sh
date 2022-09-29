#!/bin/bash
#
#script for app servers
{
SID=$1
# export sap folders from DI
TARTARGET="$SID/${SID}_$(hostname)_sap_folders_oracli_DIA.tar"
tar cvf - /oracle/client/1* /usr/sap/ccms /usr/sap/DA* /usr/sap/$SID/SYS /usr/sap/hostctrl /etc/rc.d/init.d/sapinit /usr/sap/scripts /usr/sap/sapservices /usr/sap/tmp/grmg /sapmnt/$SID/exe | ssh scp@192.168.58.82 "cat > /share/pub/basis/Systems_export/$TARTARGET" 2>&1 | tee $LOGFILE
} 2>&1 | tee /tmp/_export_log_$(date +"%Y_%m_%d_%I_%M_%p").txt