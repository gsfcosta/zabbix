#!/bin/bash
vso=$(cat /zabbix/.config/var/versionso.txt)
vzbx=$(cat /zabbix/.config/var/versionzbx.txt)
vprimary=$(cat /zabbix/.config/var/versionprimary.txt)
rpm -Uvh http://repo.zabbix.com/zabbix/$vprimary/rhel/$vso/x86_64/zabbix-agent-$vzbx
if (( $? != )); then
	dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - Download do repositório" 0 0	
	exit
fi
yum install zabbix-agent -y
function zbx(){
server=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração do agent" --inputbox 'IP Server:' 0 0 )
if (( $? == 0 )); then
        hostnm
else
	dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
        zbx
fi
}
function hostnm(){
hsts=$( dialog --stdout --ok-label Confirm --cancel-label Return --title "Configuração do agent" --inputbox 'Hostname:' 0 0 )
if (( $? == 0 )); then   
	echo "PidFile=/var/run/zabbix/zabbix_agentd.pid" > /etc/zabbix/zabbix_agentd.conf
	echo "LogFile=/var/log/zabbix/zabbix_agentd.log" >> /etc/zabbix/zabbix_agentd.conf
	echo "Include=/etc/zabbix/zabbix_agentd.d/*.conf" >> /etc/zabbix/zabbix_agentd.conf
	echo "Server=$server" >> /etc/zabbix/zabbix_agentd.conf
	echo "ServerActive=$server" >> /etc/zabbix/zabbix_agentd.conf
	echo "Hostname=$hsts" >> /etc/zabbix/zabbix_agentd.conf
	cont
elif (( $? == 1 )); then
        zbx
else
        exit
fi
}
function cont(){
chmod 777 /run/zabbix -R
systemctl restart zabbix-agent
chkconfig zabbix-agent on 
dialog --backtitle "LRS Tecnologia LTDA" --msgbox "Instalação Completa" 0 0
dialog --backtitle "LRS Tecnologia LTDA" --title "LOG zabbix_agent" --tailbox /var/log/zabbix/zabbix_agentd.log 100 100
exit
}
zbx
