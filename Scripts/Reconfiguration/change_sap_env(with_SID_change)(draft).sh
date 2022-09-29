# Скрипт по адаптации файлов серверов приложений под нужный hostname и инстанцию
# запускать под root
echo Input source SID:
read SID
echo Input source hostname:
read sourcehost
echo Input target SID:
read TSID
echo Input Dialog instance number in DXX format like D02:
read targetinstance
sourceinstance=D01
sid=$(echo "$SID" | tr '[:upper:]' '[:lower:]')
tsid=$(echo "$TSID" | tr '[:upper:]' '[:lower:]')
echo "tar -xvf /share/pub/basis/Systems_export/"$SID"/"$SID"_"$sourcehost"_users_home.tar -C /"
tar -xvf /share/pub/basis/Systems_export/"$SID"/"$SID"_"$sourcehost"_sap_folders_oracli_DIA.tar -C /
tar -xvf /share/pub/basis/Systems_export/"$SID"/"$SID"_"$sourcehost"_users_home.tar -C /
mv /home/da1adm/.j2eeenv_"$sourcehost".csh /home/da1adm/.j2eeenv_$(hostname -s).csh
mv /home/da1adm/.j2eeenv_"$sourcehost".sh /home/da1adm/.j2eeenv_$(hostname -s).sh
mv /home/da1adm/.sapenv_"$sourcehost".csh /home/da1adm/.sapenv_$(hostname -s).csh
mv /home/da1adm/.sapenv_"$sourcehost".sh /home/da1adm/.sapenv_$(hostname -s).sh
mv /home/da1adm/.sapsrc_"$sourcehost".csh /home/da1adm/.sapsrc_$(hostname -s).csh
mv /home/da1adm/.sapsrc_"$sourcehost".sh /home/da1adm/.sapsrc_$(hostname -s).sh
mv /home/"$sid""adm"/.dbenv_"$sourcehost".csh /home/"$tsid""adm"/.dbenv_$(hostname -s).csh
mv /home/"$sid""adm"/.dbenv_"$sourcehost".sh /home/"$tsid""adm"/.dbenv_$(hostname -s).sh
mv /home/"$sid""adm"/.j2eeenv_"$sourcehost".csh /home/"$tsid""adm"/.j2eeenv_$(hostname -s).csh
mv /home/"$sid""adm"/.j2eeenv_"$sourcehost".sh /home/"$tsid""adm"/.j2eeenv_$(hostname -s).sh
mv /home/"$sid""adm"/.sapenv_"$sourcehost".csh /home/"$tsid""adm"/.sapenv_$(hostname -s).csh
mv /home/"$sid""adm"/.sapenv_"$sourcehost".sh /home/"$tsid""adm"/.sapenv_$(hostname -s).sh
mv /home/"$sid""adm"/.sapsrc_"$sourcehost".csh /home/"$tsid""adm"/.sapsrc_$(hostname -s).csh
mv /home/"$sid""adm"/.sapsrc_"$sourcehost".sh /home/"$tsid""adm"/.sapsrc_$(hostname -s).sh
mv /usr/sap/DA1/SYS/profile/DA1_SMDA97_"$sourcehost" /usr/sap/DA1/SYS/profile/DA1_SMDA97_$(hostname -s)
mv /usr/sap/DA1/SYS/profile/DA1_SMDA98_"$sourcehost" /usr/sap/DA1/SYS/profile/DA1_SMDA98_$(hostname -s)
mv /usr/sap/DA1/SYS/profile/DA2_SMDA97_"$sourcehost" /usr/sap/DA2/SYS/profile/DA1_SMDA97_$(hostname -s)
mv /usr/sap/DA1/SYS/profile/DA2_SMDA98_"$sourcehost" /usr/sap/DA2/SYS/profile/DA1_SMDA98_$(hostname -s)
sed -i "s/"$sourcehost"/$(hostname -s)/g" /usr/sap/sapservices
sed -i "s/"$SID"/$TSID/g" /usr/sap/sapservices
sed -i "s/"$sid""adm"/"$tsid""adm"/g" /usr/sap/sapservices
sed -i "s/"$sourceinstance"/"$targetinstance"/g" /usr/sap/sapservices
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA1/SYS/profile/DA1_SMDA97_$(hostname -s)"
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA2/SYS/profile/DA1_SMDA97_$(hostname -s)"
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA1/SYS/profile/DA1_SMDA98_$(hostname -s)"
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA2/SYS/profile/DA1_SMDA98_$(hostname -s)"

mkdir /usr/sap/trans
chown "$tsid""adm":sapsys /usr/sap/trans
chmod 771 /usr/sap/trans

mkdir /usr/sap/trans/ARCHIVE
chown "$tsid""adm":sapsys /usr/sap/trans/ARCHIVE
chmod 755 /usr/sap/trans/ARCHIVE

mkdir /sapmnt/"$TSID"
chown "$tsid""adm":sapsys /sapmnt/"$TSID"
chmod 755 /sapmnt/"$TSID"

mkdir /sapmnt/"$TSID"/global
chown "$tsid""adm":sapsys /sapmnt/"$TSID"/global
chmod 755 /sapmnt/"$TSID"/global

mkdir /sapmnt/"$TSID"/profile
chown "$tsid""adm":sapsys /sapmnt/"$TSID"/profile
chmod 755 /sapmnt/"$TSID"/profile

mkdir /usr/sap/"$TSID"
chown "$tsid""adm":sapsys /usr/sap/"$TSID"
chmod 755 /usr/sap/"$TSID"

mkdir /usr/sap/"$TSID"/"$targetinstance"
chown "$tsid""adm":sapsys /usr/sap/"$TSID"/"$targetinstance"
chmod 755 /usr/sap/"$TSID"/"$targetinstance"

mv /usr/sap/"$SID"/SYS /usr/sap/"$TSID"/SYS

ln -sfn /sapmnt/"$TSID"/global /usr/sap/"$TSID"/SYS/global
ln -sfn /sapmnt/"$TSID"/profile /usr/sap/"$TSID"/SYS/profile
ln -sfn /sapmnt/"$TSID"/exe/uc/linuxx86_64 /usr/sap/"$TSID"/SYS/exe/dbg
ln -sfn /sapmnt/"$TSID"/exe/nuc /usr/sap/"$TSID"/SYS/exe/nuc
ln -sfn /sapmnt/"$TSID"/exe/jvm /usr/sap/"$TSID"/SYS/exe/jvm
ln -sfn /usr/sap/"$TSID"/SYS/exe/dbg /usr/sap/"$TSID"/SYS/exe/run
ln -sfn /sapmnt/"$TSID"/exe/uc /usr/sap/"$TSID"/SYS/exe/uc