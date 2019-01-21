#!/bin/bash
vprimary=$(cat /zabbix/.config/var/versionprimary.txt)
vzbx=$(cat /zabbix/.config/var/versionzbx.txt)
wget http://repo.zabbix.com/zabbix/$vprimary/debian/pool/main/z/zabbix-release/zabbix-release_$vzbx
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - download do repo zabbix" 0 0
        exit
fi
dpkg -i zabbix-release_$vzbx
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - Instalação do repo zabbix" 0 0
        exit
fi
apt-get install zabbix-agent -y
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - instalação do zabbix agent" 0 0
        exit
fi
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
hostname=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração do agent" --inputbox 'Hostname:' 0 0 )
if (( $? == 0 )); then
        srv
else
        dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
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
systemctl restart zabbix-agent 
iptables -F
dialog --backtitle "LRS Tecnologia LTDA" --ok-label ok --msgbox "Instalação completa" 0 0
dialog --backtitle "LRS Tecnologia LTDA" --title "LOG zabbix_agentd" --tailbox /var/log/zabbix/zabbix_agentd.log 100 100
exit
}
zbx