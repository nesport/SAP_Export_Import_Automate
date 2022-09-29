while IFS= read -r dest; do
  scp /share/pub/basis/Systems_export/ER1/ER1_er1ap48_sap_folders_oracli_DIA.tar "er1adm@$dest:/tmp/"
done <destfile.txt
