#!/bin/bash
# 
SID=$1

# export sap folders
TARTARGET="$SID/${SID}_sap_profiles.tar"
tar cvf - /sapmnt/$SID/profile  | ssh scp@192.168.63.82 "cat > /share/pub/basis/Systems_export/$TARTARGET"

