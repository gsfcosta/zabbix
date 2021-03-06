#!/bin/bash
clear
cat /etc/*-release | grep -i debian
if (( $? == 0 )); then
apt-get update -y
dialog
if (( $? != 0 )); then
        apt-get install dialog -y
fi
else
	cat /etc/*-release | grep -i ubuntu
	if (( $? == 0 )); then
	apt-get update -y
	dialog
		if (( $? != 0 )); then
	        apt-get install dialog -y
		fi
	else
	cat /etc/*-release | grep -i centos
	if (( $? == 0 )); then
		yum update -y
		yum install epel-release -y
		dialog
		if (( $? != 0 )); then
	        	yum install dialog -y
		fi
	else
		cat /etc/*-release | grep -i suse
	        if (( $? == 0 )); then
        	        zypper update -y
               		dialog
                if (( $? != 0 )); then
                        zypper install dialog -y
                fi

        	fi

	fi
	fi
fi
dialog --backtitle "ZABBIX INSTALL" --ok-label Entrar --msgbox "Bem-vindo!" 0 0
if (( $? == 0 )); then
  bash /zabbix/.config/config.sh
else
  exit
fi
