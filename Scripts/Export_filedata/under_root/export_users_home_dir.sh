#!/bin/bash
#
# export users profiles 
{
SID=$1
TARTARGET="$SID/${SID}_$(hostname)_users_home.tar"
tar cvf - /home/*adm | ssh scp@192.168.58.82 "cat > /share/pub/basis/Systems_export/$TARTARGET"
} 2>&1 | tee /tmp/_export_log_$(date +"%Y_%m_%d_%I_%M_%p").txt