#!/bin/bash
# 
# export oracle db configs
SID=$SAPSYSTEMNAME

TARTARGET="$SID/${SID}_oracle_db_configs.tar"
tar cvf - /etc/oratab /oracle/$SID/12102/dbs /oracle/$SID/12102/network/admin  | ssh scp@192.168.63.82 "cat > /share/pub/basis/Systems_export/$TARTARGET"

# export oracle bins
#TARTARGET="$SID/${SID}_oraclebin.tar.gz"
#tar cvf - /oracle/admin /oracle/agent /oracle/cfgtoollogs /oracle/checkpoints /oracle/diag /oracle/lost+found /oracle/oradata/$SID /oracle/oraInventory /oracle/$SID/121 /oracle/$SID/  | ssh erxadm@192.168.106.14 "cat > /usr/sap/trans/ARCHIVE/FOR_MIGRATION/SAP/$TARTARGET2"

