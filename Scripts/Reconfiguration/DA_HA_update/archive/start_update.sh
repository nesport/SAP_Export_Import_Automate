# To start update DA and HA check list of server and type "yes"
echo Input target DA SID (DA0,DA1,DA2):
read SID
readarray upd_list < servers_to_update.txt
echo "Target servers:"
echo "${upd_list[*]}" 
read -p "Are you sure? " -n 3 -r
echo    # (optional) move to a new line
if [[ "$REPLY" = "yes" ]]
then
for i in "${arrayName[@]}"
do
  case `uname` in
  AIX*)
       echo "Detected as AIX";;
       aix_update_$SID.sh  
       echo "Updated!";;
  Linux*)
       echo "Detected as Linux";;
       linux_update_$SID.sh  
       echo "Updated!";;
  esac
done
fi