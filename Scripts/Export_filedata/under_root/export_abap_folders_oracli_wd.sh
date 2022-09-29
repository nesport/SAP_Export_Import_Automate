#!/bin/bash
#
# export sap folders with ora client from CI ( !! without logs and global !!)
{
SID=$1
TARTARGET="$SID/${SID}_$(hostname)_sap_folders_oracli_CI.tar"
tar cvf - /oracle/client/12* /usr/sap/ccms /usr/sap/hostctrl /etc/rc.d/init.d/sapinit /usr/sap/scripts /usr/sap/sapservices /usr/sap/tmp/grmg /usr/sap/$SID/SYS/exe /usr/sap/$SID/SYS/profile /usr/sap/$SID/SYS/src /usr/sap/$SID/SYS/gen  /usr/sap/$SID/W* | ssh scp@192.168.63.82 "cat > /share/pub/basis/Systems_export/$TARTARGET" 2>&1 | tee $LOGFILE
} 2>&1 | tee /tmp/_export_log_$(date +"%Y_%m_%d_%I_%M_%p").txt