#!/bin/bash
#
#script for enq servers
{
SID=$1
# export sap folders from ENQ
TARTARGET="$SID/${SID}_$(hostname)_sap_folders_ENQ.tar"
tar cvf - /usr/sap/ccms /usr/sap/DA* /usr/sap/$SID /usr/sap/hostctrl /etc/rc.d/init.d/sapinit /usr/sap/scripts/nmon_stat/*nmon_stat.sh /usr/sap/sapservices /usr/sap/tmp/grmg /usr/sap/enqlog /sapmnt/$SID/exe /sapmnt/$SID/global /sapmnt/$SID/profile | ssh scp@192.168.58.82 "cat > /share/pub/basis/Systems_export/$TARTARGET" 2>&1 | tee $LOGFILE
} 2>&1 | tee /tmp/_export_log_$(date +"%Y_%m_%d_%I_%M_%p").txt
