#!/bin/bash
#
# export sap folders with ora client from CI ( !! without logs and global !!)
SID=$1

TARTARGET="$SID/${SID}_$(hostname)_sap_folders_oracli_CI.tar"
tar cvf - /oracle/client/12* /usr/sap/ccms /usr/sap/DA* /usr/sap/hostctrl /etc/rc.d/init.d/sapinit /usr/sap/scripts /usr/sap/sapservices /usr/sap/tmp/grmg /sapmnt/$SID/exe /sapmnt/$SID/profile /usr/sap/$SID/SYS/exe /usr/sap/$SID/SYS/profile /usr/sap/$SID/SYS/src /usr/sap/$SID/SYS/gen /usr/sap/$SID/*SCS*/log/grmg /usr/sap/$SID/*SCS*/data /usr/sap/$SID/ASCS*/exe  /usr/sap/$SID/*SCS*/sec  /usr/sap/$SID/*SCS*/work/available.log  /usr/sap/$SID/D*/log/grmg /usr/sap/$SID/J*/data /usr/sap/$SID/J*/exe  /usr/sap/$SID/J*/sec  /usr/sap/$SID/J*/work/available.log | ssh scp@192.168.63.82 "cat > /share/pub/basis/Systems_export/$TARTARGET"