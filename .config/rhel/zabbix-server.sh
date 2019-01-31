#!/bin/bash
vso=$(cat /zabbix/.config/var/versionso.txt)
vprimary=$(cat /zabbix/.config/var/versionprimary.txt)
vzbx=$(cat /zabbix/.config/var/versionzbx.txt)
fpingrpm=$(cat /zabbix/.config/var/fpingrpm.txt)
libeventrpm=$(cat /zabbix/.config/var/libeventrpm.txt)
unixodbcrpm=$(cat /zabbix/.config/var/unixodbcrpm.txt)
phprpm=$(cat /zabbix/.config/var/phprpm.txt)
epelrpm=$(cat /zabbix/.config/var/epelrpm.txt)
yum install wget gcc gcc-c++ kernel-devel OpenIPMI-libs net-snmp php -y
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação das dependencias" 0 0
        exit
fi
rpm -ivh /zabbix/.config/archives/$fpingrpm 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação do fping" 0 0
        exit
fi
yum install fping -y 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação do fping pelo repo" 0 0
        exit
fi
rpm -ivh /zabbix/.config/archives/$libeventrpm 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? download e instalação do libevent" 0 0
        exit
fi
rpm -ivh /zabbix/.config/archives/$unixodbcrpm 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - download e instalação do OBDC" 0 0
        exit
fi
rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - importação key zabbix" 0 0
        exit
fi
rpm -ivh http://repo.zabbix.com/zabbix/$vprimary/rhel/$vso/x86_64/zabbix-release-$vzbx 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - download e instalação do repo zabbix" 0 0
        exit
fi
case $vso in
	6) subscription-manager repos --enable=rhel-6-server-optional-rpms;;
	7) subscription-manager repos --enable=rhel-7-server-optional-rpms;;
esac
rpm -Uvh /zabbix/.config/archives/$phprpm 
#if (( $? != 0 )); then
#        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Download repo php" 0 0
#        exit
#fi
rpm -Uvh /zabbix/.config/archives/$epelrpm
#if (( $? != 0 )); then
#        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Download repo epel" 0 0
#        exit
#fi
yum install php-mbstring -y
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Instalação dos repo mb-string" 0 0
        exit
fi
yum install zabbix-server-mysql zabbix-web-mysql mariadb-server -y 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação do zabbix server e mariadb server 2" 0 0
        exit
fi
systemctl enable mariadb && systemctl start mariadb 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - habilitação do mariadb" 0 0
        exit
fi
function menuroot(){
opcao=$(dialog --stdout                                        \
        --backtitle "ZABBIX INSTALL"               \
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
	dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
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
                                dialog --backtitle "ZABBIX INSTALL" --ok-label Voltar --msgbox "Senhas não combinam" 0 0
                                rot2
                        fi   
                elif (( $? == 1 )); then
                        menuroot
                else
			dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
			rot2
                fi
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
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
	dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
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
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
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
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
	senhadb
fi
}
function cont(){
if (( $varmy == 2 )); then
	mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$root2');"
	mysql -u root -p$root2 -e "create database $namedb character set utf8 collate utf8_bin; grant all privileges on $namedb.* to $userdb@localhost identified by '$passdb'; flush privileges;" #2012/10/13
elif (( $varmy == 1 )); then
	mysql -u root -p$rot -e "create database $namedb character set utf8 collate utf8_bin; grant all privileges on $namedb.* to $userdb@localhost identified by '$passdb'; flush privileges;" 
fi
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Configuração do banco de dados" 0 0
        exit
fi
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -u $userdb $namedb -p$passdb
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Utilização do zcat" 0 0
        exit
fi
srv
}
function srv(){
echo "LogFile=/var/log/zabbix/zabbix_server.log" > /etc/zabbix/zabbix_server.conf
echo "PidFile=/var/run/zabbix/zabbix_server.pid" >> /etc/zabbix/zabbix_server.conf
echo "SocketDir=/var/run/zabbix" >> /etc/zabbix/zabbix_server.conf
echo "DBName=$namedb" >> /etc/zabbix/zabbix_server.conf
echo "DBUser=$userdb" >> /etc/zabbix/zabbix_server.conf
echo "DBPassword=$passdb" >> /etc/zabbix/zabbix_server.conf
echo "SNMPTrapperFile=/var/log/snmptrap/snmptrap.log" >> /etc/zabbix/zabbix_server.conf
echo "Timeout=4" >> /etc/zabbix/zabbix_server.conf
echo "AlertScriptsPath=/usr/lib/zabbix/alertscripts" >> /etc/zabbix/zabbix_server.conf
echo "ExternalScripts=/usr/lib/zabbix/externalscripts" >> /etc/zabbix/zabbix_server.conf
echo "LogSlowQueries=3000" >> /etc/zabbix/zabbix_server.conf
fin
}
function fin(){
iptables -F
sed 's/# php_value date.timezone Europe/php_value date.timezone America/' -i /etc/httpd/conf.d/zabbix.conf
sed 's/Riga/Sao_Paulo/' -i /etc/httpd/conf.d/zabbix.conf
chmod 777 /run/zabbix/* -R
systemctl restart zabbix-server httpd 
systemctl enable zabbix-server httpd 
iptables -F
dialog --backtitle "ZABBIX INSTALL" --ok-label ok --msgbox "Instalação completa" 0 0
dialog --backtitle "ZABBIX INSTALL" --title "LOG zabbix_server" --tailbox /var/log/zabbix/zabbix_server.log 100 100
exit
}
menuroot
