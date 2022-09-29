# Скрипт по адаптации файлов серверов приложений под нужный hostname и инстанцию
# запускать под root
echo Input SID:
read SID
echo Input source hostname:
read sourcehost
echo Input Dialog instance number in DXX format like D02:
read targetinstance
sourceinstance=D01
sid=$(echo "$SID" | tr '[:upper:]' '[:lower:]')
echo "tar -xvf /share/pub/basis/Systems_export/"$SID"/"$SID"_"$sourcehost"_users_home.tar -C /"
tar -xvf /share/pub/basis/Systems_export/"$SID"/"$SID"_"$sourcehost"_sap_folders_oracli_DIA.tar -C /
tar -xvf /share/pub/basis/Systems_export/"$SID"/"$SID"_"$sourcehost"_users_home.tar -C /
mv /home/da1adm/.j2eeenv_"$sourcehost".csh /home/da1adm/.j2eeenv_$(hostname -s).csh
mv /home/da1adm/.j2eeenv_"$sourcehost".sh /home/da1adm/.j2eeenv_$(hostname -s).sh
mv /home/da1adm/.sapenv_"$sourcehost".csh /home/da1adm/.sapenv_$(hostname -s).csh
mv /home/da1adm/.sapenv_"$sourcehost".sh /home/da1adm/.sapenv_$(hostname -s).sh
mv /home/da1adm/.sapsrc_"$sourcehost".csh /home/da1adm/.sapsrc_$(hostname -s).csh
mv /home/da1adm/.sapsrc_"$sourcehost".sh /home/da1adm/.sapsrc_$(hostname -s).sh
mv /home/"$sid""adm"/.dbenv_"$sourcehost".csh /home/"$sid""adm"/.dbenv_$(hostname -s).csh
mv /home/"$sid""adm"/.dbenv_"$sourcehost".sh /home/"$sid""adm"/.dbenv_$(hostname -s).sh
mv /home/"$sid""adm"/.j2eeenv_"$sourcehost".csh /home/"$sid""adm"/.j2eeenv_$(hostname -s).csh
mv /home/"$sid""adm"/.j2eeenv_"$sourcehost".sh /home/"$sid""adm"/.j2eeenv_$(hostname -s).sh
mv /home/"$sid""adm"/.sapenv_"$sourcehost".csh /home/"$sid""adm"/.sapenv_$(hostname -s).csh
mv /home/"$sid""adm"/.sapenv_"$sourcehost".sh /home/"$sid""adm"/.sapenv_$(hostname -s).sh
mv /home/"$sid""adm"/.sapsrc_"$sourcehost".csh /home/"$sid""adm"/.sapsrc_$(hostname -s).csh
mv /home/"$sid""adm"/.sapsrc_"$sourcehost".sh /home/"$sid""adm"/.sapsrc_$(hostname -s).sh
mv /usr/sap/DA1/SYS/profile/DA1_SMDA97_"$sourcehost" /usr/sap/DA1/SYS/profile/DA1_SMDA97_$(hostname -s)
mv /usr/sap/DA1/SYS/profile/DA1_SMDA98_"$sourcehost" /usr/sap/DA1/SYS/profile/DA1_SMDA98_$(hostname -s)
mv /usr/sap/DA1/SYS/profile/DA2_SMDA97_"$sourcehost" /usr/sap/DA2/SYS/profile/DA1_SMDA97_$(hostname -s)
mv /usr/sap/DA1/SYS/profile/DA2_SMDA98_"$sourcehost" /usr/sap/DA2/SYS/profile/DA1_SMDA98_$(hostname -s)
sed -i "s/"$sourcehost"/$(hostname -s)/g" /usr/sap/sapservices
sed -i "s/"$sourceinstance"/"$targetinstance"/g" /usr/sap/sapservices
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA1/SYS/profile/DA1_SMDA97_$(hostname -s)"
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA2/SYS/profile/DA1_SMDA97_$(hostname -s)"
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA1/SYS/profile/DA1_SMDA98_$(hostname -s)"
sed -i "s/"$sourcehost"/$(hostname -s)/g" "/usr/sap/DA2/SYS/profile/DA1_SMDA98_$(hostname -s)"

mkdir /usr/sap/trans
chown "$sid""adm":sapsys /usr/sap/trans
chmod 771 /usr/sap/trans

mkdir /usr/sap/trans/ARCHIVE
chown "$sid""adm":sapsys /usr/sap/trans/ARCHIVE
chmod 755 /usr/sap/trans/ARCHIVE

mkdir /sapmnt/"$SID"
chown "$sid""adm":sapsys /sapmnt/"$SID"
chmod 755 /sapmnt/"$SID"

mkdir /sapmnt/"$SID"/global
chown "$sid""adm":sapsys /sapmnt/"$SID"/global
chmod 755 /sapmnt/"$SID"/global

mkdir /sapmnt/"$SID"/profile
chown "$sid""adm":sapsys /sapmnt/"$SID"/profile
chmod 755 /sapmnt/"$SID"/profile

mkdir /usr/sap/"$SID"
chown "$tsid""adm":sapsys /usr/sap/"$SID"
chmod 755 /usr/sap/"$SID"

mkdir /usr/sap/"$SID"/"$targetinstance"
chown "$sid""adm":sapsys /usr/sap/"$SID"/"$targetinstance"
chmod 755 /usr/sap/"$SID"/"$targetinstance"



