#!/bin/bash
#
# export sap folders with ora client from CI ( !! without logs and global !!)
SID=$SAPSYSTEMNAME

TARTARGET="$SID/${SID}_$(hostname)_sap_folders_oracli_CI.tar"
tar cvf - /oracle/client/12* /usr/sap/ccms /usr/sap/DA* /usr/sap/hostctrl /usr/sap/$SID/sapwebdisp /etc/rc.d/init.d/sapinit /usr/sap/scripts /usr/sap/sapservices /usr/sap/tmp/grmg /sapmnt/$SID/exe /sapmnt/$SID/profile /usr/sap/$SID/SYS/exe /usr/sap/$SID/SYS/profile /usr/sap/$SID/SYS/src /usr/sap/$SID/SYS/gen /usr/sap/$SID/ASCS*/log/grmg /usr/sap/$SID/ASCS*/data /usr/sap/$SID/ASCS*/exe  /usr/sap/$SID/ASCS*/sec  /usr/sap/$SID/ASCS*/work/available.log  /usr/sap/$SID/D*/log/grmg /usr/sap/$SID/D*/data /usr/sap/$SID/D*/exe  /usr/sap/$SID/D*/sec  /usr/sap/$SID/D*/work/available.log | ssh scp@192.168.63.82 "cat > /share/pub/basis/Systems_export/$TARTARGET"