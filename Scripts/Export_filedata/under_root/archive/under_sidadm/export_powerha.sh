#!/bin/bash
#
# export powerha 
SID=$SAPSYSTEMNAME
TARTARGET="$SID/${SID}_$(hostname)_powerha(app).tar"
tar cvf - /etc/hacmp/ /usr/es/sbin/cluster/app/ | ssh scp@192.168.63.82 "cat > /share/pub/basis/Systems_export/$TARTARGET"
