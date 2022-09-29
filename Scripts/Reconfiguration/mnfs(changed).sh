#!/bin/ksh
##################################################################
# mnfs  /etc/hacmp/mnfs 
##################################################################

##################################################################
# Mount folders
##################################################################

# запускать под root
echo Input SID:
read WPSID

echo Input Dialog instance number in XX format like 02:
read WPNR

echo Input CI hostname:
read SERVER

OS=`uname`
set NFSE=""

echo "***Script *mnfs* started at " `date` >> $OUT

case $OS in  
 AIX )
  NFSE="/usr/sap/trans /usr/sap/trans/ARCHIVE /usr/sap/$WPSID /sapmnt/$WPSID" 
  for nfls in $NFSE
   do
    mount | grep $nfls > /dev/null 2>&1
     if [ $? -ne 0 ]
      then 
      mount -v nfs -o rw -o soft $SERVER:$nfls $nfls
     if [ $? -ne 0 ]
      then
      sleep 5
      mount -v nfs -o rw -o soft $SERVER:$nfls $nfls
       if [ $? -ne 0 ]
       then
       echo "Cannot mount $nfls" >> $OUT
       fi
     fi
     fi
    done ;;
 Linux )
  NFSE="/usr/sap/trans /usr/sap/trans/ARCHIVE /sapmnt/$WPSID/global /sapmnt/$WPSID/profile /usr/sap/$WPSID/D$WPNR" 
  for nfls in $NFSE
   do
    mount | grep $nfls > /dev/null 2>&1
     if [ $? -ne 0 ]
      then 
      mount -t nfs -o rw -o soft $SERVER:$nfls $nfls -o nfsvers=3
     if [ $? -ne 0 ]
      then
      sleep 5
      mount -t nfs -o rw -o soft $SERVER:$nfls $nfls -o nfsvers=3
       if [ $? -ne 0 ]
       then
       echo "Cannot mount $nfls" >> $OUT
       fi
     fi
     fi
    done ;;
  * )
	echo "***Unsupported OS detected ***" >> $OUT ;;
esac

##################################################################
echo "*** NFS mounted $NFSE ***" >> $OUT
echo "***Script *mnfs* stopped at " `date` >> $OUT
##################################################################
