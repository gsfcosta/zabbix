#!/bin/bash
clear
yum update -y
yum install epel-release -y
dialog
if (( $? != 0 )); then
        yum install dialog -y
fi
dialog --backtitle "LRS Tecnologia LTDA" --ok-label Reiniciar --msgbox "Bem-vindo!" 0 0
if (( $? == 0 )); then
  bash /zabbix/.config/config.sh
else
  exit
fi
