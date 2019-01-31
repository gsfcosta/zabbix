#!/bin/bash
rpm -Uvh --nosignature https://repo.zabbix.com/zabbix/4.0/sles/12/x86_64/zabbix-release-4.0-1.el12.noarch.rpm
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - download do repo zabbix" 0 0
        exit
fi
zypper --gpg-auto-import-keys refresh 'Zabbix Official Repository'
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Instalação do repo zabbix" 0 0
        exit
fi
zypper install -y zabbix-agent
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação do zabbix agent" 0 0
        exit
fi
function zbx(){
server=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração do agent" --inputbox 'IP Server:' 0 0 )
if (( $? == 0 )); then
        hostnm
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
        zbx
fi
}
function hostnm(){
hostname=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração do agent" --inputbox 'Hostname:' 0 0 )
if (( $? == 0 )); then
        srv
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
        hostnm
fi
}
function srv(){
echo "LogFile=/var/log/zabbix/zabbix_agentd.log" > /etc/zabbix/zabbix_agentd.conf
echo "PidFile=/var/run/zabbix/zabbix_agentd.pid" >> /etc/zabbix/zabbix_agentd.conf
#echo "SocketDir=/var/run/zabbix" >> /etc/zabbix/zabbix_agentd.conf
echo "EnableRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf
echo "Server=$server" >> /etc/zabbix/zabbix_agentd.conf
echo "ServerActive=$server" >> /etc/zabbix/zabbix_agentd.conf
echo "Hostname=$hostname" >> /etc/zabbix/zabbix_agentd.conf
echo "Include=/etc/zabbix/zabbix_agentd.d/*.conf" >> /etc/zabbix/zabbix_agentd.conf
fin
}
function fin(){
iptables -F
chmod 777 /run/zabbix/* -R
systemctl enable zabbix-agent
systemctl restart zabbix-agent 
iptables -F
dialog --backtitle "ZABBIX INSTALL" --ok-label ok --msgbox "Instalação completa" 0 0
dialog --backtitle "ZABBIX INSTALL" --title "LOG zabbix_agentd" --tailbox /var/log/zabbix/zabbix_agentd.log 100 100
exit
}
zbx
