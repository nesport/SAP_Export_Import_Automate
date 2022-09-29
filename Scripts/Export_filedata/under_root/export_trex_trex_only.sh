#!/bin/bash
#
#script for TREX servers 
{
SID=$1
# export sap folders from DI
TARTARGET="$SID/${SID}_$(hostname)_trex_only.tar"
tar cvf - /usr/sap/${SID}  | ssh scp@192.168.58.82 "cat > /share/pub/basis/Systems_export/$TARTARGET" 2>&1 | tee $LOGFILE
} 2>&1 | tee /tmp/_export_log_$(date +"%Y_%m_%d_%I_%M_%p").txt
