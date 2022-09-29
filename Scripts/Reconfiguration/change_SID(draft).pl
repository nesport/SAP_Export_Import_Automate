as hrtadm
cd /home/hrtadm
perl -p -i.bak -e 's/HR4/HRT/g' .dbenv.csh .dbenv.sh .sapenv.csh .sapenv.sh

cd /usr/sap
perl -p -i.bak -e 's/HR4/HRT/g ; s/hr4/hrt/g' sapservices


cd /sapmnt/HRT/profile
perl -p -i.bak -e 's/HR4/HRT/g ; s/hr4/hrt/g' DEFAULT.PFL HRT_ASCS04_hrtcidb HRT_DVEBMGS03_hrtcidb

cd /sapmnt/HRT/profile/oracle
perl -p -i.bak -e 's/HR4/HRT/g ; s/hr4/hrt/g' tnsnames.ora