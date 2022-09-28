# SAP Export-Import system 

Скрипты рабочие для SWPM и Linux на 2018 г.

change_sap_env.sh - заменяет имя сервера и выставляет под нужный номер инстанции

По выгрузке данных в папке  ./Export_filedata/under_root

export_abap_folders_enq.sh - выгрузка с Enqueue сервера 
export_abap_folders_oracli_ci.sh - выгрузка файлов  с ABAP CI . Не включены домашние директории и HA-скрипты
export_abap_folders_oracli_dia.sh - выгрузка файлов с ABAP DIA . Не включены домашние директории и HA-скрипты
export_abap_folders_oracli_wd.sh - выгрузка файлов с ABAP WebDisp . Не включены домашние директории и HA-скрипты
export_java_folders_oracli_ci.sh - выгрузка файлов  с Java CI . Не включены домашние директории и HA-скрипты
export_java_folders_oracli_dia.sh - выгрузка файлов  с Java DIA . Не включены домашние директории и HA-скрипты

export_trex_folders_oracli_dia.sh - выгрузка

export_oracle_db_configs.sh - выгрузка окружения Oracle
export_powerha.sh - экспорт HA-скриптов . Выгружаются все
export_sap_profiles.sh - экспорт профилей SAP
export_users_home_dir.sh - экспорт домашних директорий для учетных запиcей по маске *adm

По проверке систем и получению информации в папке ./System_checks

check_and_info_rhel.sh - Проверка на соответствие чек-листу  и получение информации для выверки серверов RHEL

check_and_info_aix.sh - Проверка на соответствие чек-листу  и получение информации для выверки серверов AIX

check_rhel.sh - Проверка RHEL на соответствие чек-листу 

check_ot_aix.sh - Проверка AIX на соответствие чек-листу 

server_info_aix.sh - Получение информации из AIX
server_info_rhel.sh  - Получение информации из RHEL

Ansible
Как использовать:
Получение результатов команды с серверов:

ansible <группа_серверов> -m raw -a  <command>



Серверы описаны в файле указанном как параметр inventory  в конфиг файле Ansible. 

Например:

ansible all -m raw -a "hostname -s ; uname " - получение информации о типе ОС со всех серверов из inventory  с указанием hostname

ansible *0*_ci -m raw -a "hostname -s ; uname " - получение информации о типе ОС со всех СI ролей DEV  с указанием hostname

ansible *_app* -m raw -a "hostname -s ; cat /etc/passwd | grep ora; cat /etc/passwd | grep adm" - получение строк из файла passwd с фильтрацией для всех APP-серверов

 
