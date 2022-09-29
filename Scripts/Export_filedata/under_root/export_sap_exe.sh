#!/bin/bash
# 
{
SID=$1
# export sap folders
TARTARGET="$SID/${SID}_$(hostname)_sap_exe.tar"
tar cvf - /sapmnt/$SID/exe  | ssh scp@192.168.58.82 "cat > /share/pub/basis/Systems_export/$TARTARGET"
} 2>&1 | tee /tmp/_export_log_$(date +"%Y_%m_%d_%I_%M_%p").txt

