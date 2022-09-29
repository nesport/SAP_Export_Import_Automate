#!/bin/bash
# 
echo Yo basisman! Please input command like "cat /etc/passwd" or "mount" to compare:
read command
echo Input source server in EuroDC:
read source
echo Input user to login in EuroDC:
read sourceuser
echo Input target server in RosDC:
read target 
#echo Input user to login in RosDC:
#read targetuser
ssh $sourceuser@$source "$command" | sort > $home\check_file_source.txt
ssh root@$target "$command" | sort > $home\check_file_target.txt
diff -yw $home\check_file_source.txt $home\check_file_target.txt