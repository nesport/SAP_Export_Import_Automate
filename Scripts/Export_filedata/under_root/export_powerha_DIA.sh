#!/bin/bash
#
# export powerha 
{
SID=$1
TARTARGET="$SID/${SID}_$(hostname)_powerha.tar"
tar cvf - /etc/hacmp | ssh scp@192.168.63.82 "cat > /share/pub/basis/Systems_export/$TARTARGET" 2>&1 | tee $LOGFILE
} 2>&1 | tee /tmp/_export_log_$(date +"%Y_%m_%d_%I_%M_%p").txt