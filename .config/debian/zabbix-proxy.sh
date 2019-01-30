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
apt-get update
apt-get install zabbix-proxy-mysql mariadb-server -y
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - instalação do zabbix proxy mariadb server" 0 0
        exit
fi
systemctl enable mysql 
systemctl start mysql 
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - habilitação do mariadb" 0 0
        exit
fi
function menuroot(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Sair                             \
        --menu "Root do DB:"         \
        0 0 0                                           \
        1 "Usar minha senha do root"                         \
        2 "Root não tem senha (criar senha)" )
case $opcao in
        1) rot1;;
        2) rot2;;
        *) exit;;
esac
}
function rot1(){
rot=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox "Senha root do DB:" 0 0 )
if (( $? == 0 )); then
	varmy=1
	nomedb
elif (( $? == 1 )); then
	menuroot
else
	dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
	rot1	
fi
}
function rot2(){
root1=$( dialog --stdout --ok-label Confirmar --cancel-label Sair --title "Configuração MYSQL" --inputbox "Criar Senha para root do DB:" 0 0 )
if (( $? == 0 )); then
        root2=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox "Confirmar Senha:" 0 0 )
                if (( $? == 0 )); then
                        if [ $root1 == $root2 ]; then
				varmy=2
                                nomedb
                        else    
                                dialog --backtitle "LRS Tecnologia LTDA" --ok-label Voltar --msgbox "Senhas não combinam" 0 0
                                rot2
                        fi   
                elif (( $? == 1 )); then
                        menuroot
                else
			dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
			rot2
                fi
else
        dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
	rot2
fi
}
function nomedb(){
namedb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar DB:' 0 0 )
if (( $? == 0 )); then
        usuariodb
elif (( $? == 1 )); then
        menuroot
else
	dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
	nomedb
fi
}
function usuariodb(){
userdb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar usuário:' 0 0 )
if (( $? == 0 )); then
        senhadb
elif (( $? == 1 )); then
        nomedb
else
        dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
	usuariodb
fi
}
function senhadb(){
passdb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar Senha:' 0 0 )
if (( $? == 0 )); then
        cont
elif (( $? == 1 )); then
        usuariodb
else
        dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
	senhadb
fi
}
function cont(){
if (( $varmy == 2 )); then
	mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$root2');"
	mysql -u root -p$root2 -e "create database $namedb character set utf8 collate utf8_bin; grant all privileges on $namedb.* to $userdb@localhost identified by '$passdb'; flush privileges;"
elif (( $varmy == 1 )); then
	mysql -u root -p$rot -e "create database $namedb character set utf8 collate utf8_bin; grant all privileges on $namedb.* to $userdb@localhost identified by '$passdb'; flush privileges;" 
fi
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - Configuração do banco de dados" 0 0
        exit
fi
zcat /usr/share/doc/zabbix-proxy-mysql*/schema.sql.gz | mysql -u $userdb $namedb -p$passdb
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - Utilização do zcat" 0 0
        exit
fi
zbx
}
function zbx(){
server=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração do proxy" --inputbox 'IP Server:' 0 0 )
if (( $? == 0 )); then
        hostnm
else
        dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
        zbx
fi
}
function hostnm(){
hostname=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração do proxy" --inputbox 'Hostname:' 0 0 )
if (( $? == 0 )); then
        srv
else
        dialog --backtitle "LRS Tecnologia LTDA" --infobox "Por favor, termine a instação!" 0 0
        hostnm
fi
}

function srv(){
echo "Server=$server" > /etc/zabbix/zabbix_proxy.conf
echo "ServerPort=10051" >> /etc/zabbix/zabbix_proxy.conf
echo "Hostname=$hostname" >> /etc/zabbix/zabbix_proxy.conf
echo "ListenPort=10051" >> /etc/zabbix/zabbix_proxy.conf
echo "LogFile=/var/log/zabbix/zabbix_proxy.log" >> /etc/zabbix/zabbix_proxy.conf
echo "LogFileSize=0" >> /etc/zabbix/zabbix_proxy.conf
echo "EnableRemoteCommands=1" >> /etc/zabbix/zabbix_proxy.conf
echo "PidFile=/var/run/zabbix/zabbix_proxy.pid" >> /etc/zabbix/zabbix_proxy.conf
echo "SocketDir=/var/run/zabbix" >> /etc/zabbix/zabbix_proxy.conf
echo "DBName=$namedb" >> /etc/zabbix/zabbix_proxy.conf
echo "DBUser=$userdb" >> /etc/zabbix/zabbix_proxy.conf
echo "DBPassword=$passdb" >> /etc/zabbix/zabbix_proxy.conf
echo "SNMPTrapperFile=/var/log/snmptrap/snmptrap.log" >> /etc/zabbix/zabbix_proxy.conf
echo "StartSNMPTrapper=1" >> /etc/zabbix/zabbix_proxy.conf
echo "#CacheSize=8M" >> /etc/zabbix/zabbix_proxy.conf
echo "Timeout=4" >> /etc/zabbix/zabbix_proxy.conf
echo "ExternalScripts=/usr/lib/zabbix/externalscripts" >> /etc/zabbix/zabbix_proxy.conf
echo "FpingLocation=/usr/bin/fping" >> /etc/zabbix/zabbix_proxy.conf
echo "Fping6Location=/usr/bin/fping6" >> /etc/zabbix/zabbix_proxy.conf
echo "LogSlowQueries=3000" >> /etc/zabbix/zabbix_proxy.conf
fin
}
function fin(){
iptables -F
chmod 777 /run/zabbix/* -R
systemctl restart zabbix-proxy
systemctl enable zabbix-proxy
iptables -F
dialog --backtitle "LRS Tecnologia LTDA" --ok-label ok --msgbox "Instalação completa" 0 0
dialog --backtitle "LRS Tecnologia LTDA" --title "LOG zabbix_proxy" --tailbox /var/log/zabbix/zabbix_proxy.log 100 100
exit
}
menuroot
