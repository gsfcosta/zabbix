#!/bin/bash
vso=$(cat /zabbix/.config/var/versionso.txt)
vprimary=$(cat /zabbix/.config/var/versionprimary.txt)
vzbx=$(cat /zabbix/.config/var/versionzbx.txt)
fpinglink=$(cat /zabbix/.config/var/fpinglink.txt)
fpingrpm=$(cat /zabbix/.config/var/fpingrpm.txt)
libeventrpm=$(cat /zabbix/.config/var/libeventrpm.txt)
unixodbcrpm=$(cat /zabbix/.config/var/unixodbcrpm.txt)

yum install wget gcc gcc-c++ kernel-devel OpenIPMI-libs net-snmp -y | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (1/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - instalação das dependencias" 0 0
        exit
fi
wget $fpinglink  | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (2/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - download fping" 0 0
        exit
fi
rpm -ivh $fpingrpm | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (3/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - instalação do fping" 0 0
        exit
fi
yum install fping -y | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (4/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - instalação do fping pelo repo" 0 0
        exit
fi
rpm -ivh $libeventrpm | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (5/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? download e instalação do libevent" 0 0
        exit
fi
rpm -ivh $unixodbcrpm | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (6/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - download e instalação do OBDC" 0 0
        exit
fi
rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (7/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - importação key zabbix" 0 0
        exit
fi
rpm -ivh http://repo.zabbix.com/zabbix/$vprimary/rhel/$vso/x86_64/zabbix-proxy-mysql-$vzbx | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (8/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - download e instalação do repo zabbix" 0 0
        exit
fi
yum install zabbix-proxy-mysql mariadb-server -y | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (9/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - instalação do zabbix proxy e mariadb server" 0 0
        exit
fi
systemctl enable mariadb && systemctl start mariadb | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (10/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - habilitação do mariadb" 0 0
        exit
fi
function rot(){
rot=$( dialog --stdout --ok-label Confirmar --cancel-label Sair --title "Configuração MYSQL" --inputbox "Criar Senha para root do DB:" 0 0 )
if (( $? == 0 )); then
        rot2=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox "Confirmar Senha:" 0 0 )
                if (( $? == 0 )); then
                        if [ $rot == $rot2 ]; then
                                mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$rot');"
                                nomedb
                        else    
                                dialog --backtitle "LRS Tecnologia LTDA" --ok-label Voltar --msgbox "Senhas não combinam" 0 0
                                rot
                        fi   
                elif (( $? == 1 )); then
                        rot
                else
                        exit
                fi
else
        exit
fi
}
function nomedb(){
namedb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar DB:' 0 0 )
if (( $? == 0 )); then
        usuariodb
elif (( $? == 1 )); then
        rot
else
        exit
fi
}
function usuariodb(){
userdb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar usuário:' 0 0 )
if (( $? == 0 )); then
        senhadb
elif (( $? == 1 )); then
        nomedb
else
        exit
fi
}
function senhadb(){
passdb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar Senha:' 0 0 )
if (( $? == 0 )); then
        cont
elif (( $? == 1 )); then
        usuariodb
else
        exit
fi
}
function cont(){
mysql -u root -p$rot -e "create database $namedb character set utf8 collate utf8_bin; grant all privileges on $namedb.* to $userdb@localhost identified by '$passdb'; flush privileges;" | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (11/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - Configuração do banco de dados" 0 0
        exit
fi
find /usr/share/doc/ -name zabbix-proxy-mysql* > /zabbix/.config/var/zbx.txt
dirmy=$( cat /zabbix/.config/var/zbx.txt )
zcat $dirmy/schema.sql.gz | mysql -u $userdb $namedb -p$passdb | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (12/23)..." 0 0
if (( $? != 0 )); then
        dialog --backtitle "LRS Tecnologia LTDA" --ok-label Sair --msgbox "erro $? - Utilização do zcat" 0 0
        exit
fi
srv
}
function srv(){
server=$( dialog --stdout --ok-label Confirmar --cancel-label Sair --inputbox 'IP do Zabbix Server:' 0 0 )
case $? in
        0) echo "Server=$server" > /etc/zabbix/zabbix_proxy.conf; hstnm;;
        *) exit;
esac
}
function hstnm(){
hostn=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --inputbox 'Hostname:' 0 0 )
if (( $? == 0 )); then
        echo "Hostname=$hostn" >> /etc/zabbix/zabbix_proxy.conf
        echo "DBName=$namedb" >> /etc/zabbix/zabbix_proxy.conf
        echo "DBUser=$userdb" >> /etc/zabbix/zabbix_proxy.conf
        echo "DBPassword=$passdb" >> /etc/zabbix/zabbix_proxy.conf
        fin
elif (( $? == 1 )); then
        srv
else
        exit
fi
}
function fin(){
echo "LogFile=/var/log/zabbix/zabbix_proxy.log" >> /etc/zabbix/zabbix_proxy.conf

iptables -F

rm -rf /usr/lib/systemd/system/zabbix-proxy.service
cp /zabbix/.config/rhel/zabbix-proxy.service /usr/lib/systemd/system/zabbix-proxy.service

systemctl enable zabbix-proxy | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (13/23)..." 0 0
systemctl start zabbix-proxy | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (14/23)..." 0 0
yum install policycoreutils-python -y | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (15/23)..." 0 0
cat /var/log/audit/audit.log | grep zabbix_proxy | grep denied | audit2allow -M zabbix_proxy |  dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (16/23)..." 0 0
semodule -i zabbix_proxy.pp | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (17/23)..." 0 0
setsebool -P zabbix_can_network=1 | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (18/23)..." 0 0
systemctl start zabbix-proxy | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (19/23)..." 0 0
echo "module zabbix_proxy 1.0;" > zabbix_proxy.te
echo "require {" >> zabbix_proxy.te
echo "        type zabbix_t;" >> zabbix_proxy.te
echo "        type zabbix_port_t;" >> zabbix_proxy.te
echo "        class process setrlimit;" >> zabbix_proxy.te
echo "        class tcp_socket name_connect;" >> zabbix_proxy.te
echo "}" >> zabbix_proxy.te
echo " " >> zabbix_proxy.te
echo "#============= zabbix_t ==============" >> zabbix_proxy.te
echo "allow zabbix_t self:process setrlimit;" >> zabbix_proxy.te
echo " " >> zabbix_proxy.te
echo "#!!!! This avc is allowed in the current policy" >> zabbix_proxy.te
echo "allow zabbix_t zabbix_port_t:tcp_socket name_connect;" >> zabbix_proxy.te

checkmodule -m -M zabbix_proxy.te -o zabbix_proxy.mod | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (20/23)..." 0 0
semodule_package -m zabbix_proxy.mod -o zabbix_proxy.pp | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (21/23)..." 0 0
semodule -i zabbix_proxy.pp | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (22/23)..." 0 0
systemctl restart zabbix-proxy | dialog --backtitle "LRS Tecnologia LTDA" --infobox "Instalando, aguarde (23/23)..." 0 0
dialog --backtitle "LRS Tecnologia LTDA" --ok-label ok --msgbox "Instalação completa" 0 0
dialog --backtitle "LRS Tecnologia LTDA" --title "LOG zabbix_proxy" --tailbox /var/log/zabbix/zabbix_proxy.log 100 100
exit
}
rot
