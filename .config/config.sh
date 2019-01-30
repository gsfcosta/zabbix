#!/bin/bash
function menu(){
opcao=$(dialog --stdout                                        \
	--backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar  	                        \
        --cancel-label Sair                            \
        --menu "Selecione Sistema Operacional:"   	\
        0 0 0                                           \
        1 "rhel(RedHat/CentOS)"		                \
        2 "Debian"		        	        \
        3 "Ubuntu"				                \
        4 "Suse"			                \
        5 "AIX" 					\
        6 "Não sei meu SO" ) 

case $opcao in
        1) versionrhel;;
        2) echo "debian" > /zabbix/.config/var/versso.txt; versiondebian;;
        3) echo "ubuntu" > /zabbix/.config/var/versso.txt; versionubuntu;;
        4) versionsuse;;
        5) versionaix;;
        6) helpso ;;
        *) exit;;
esac
}

function versionrhel(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do rhel:"            \
        0 0 0                                           \
        1 "5"                                           \
        2 "6"                                           \
        3 "7"                                           \
        4 "Não sei minha versão"                       \
        5 "Sair" )
if (( $? == 0 )); then
	case $opcao in
	        1) echo "5" > /zabbix/.config/var/versionso.txt; rhel5;;
	        2) echo "6" > /zabbix/.config/var/versionso.txt; rhel6;;
	        3) echo "7" > /zabbix/.config/var/versionso.txt; rhel7;;
	        4) helpversion ;;
       		5) exit ;;
	esac
elif (( $? == 1 )); then
        menu
else
        exit
fi
}
function rhel5(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Agent"                                \
        2 "Sair" )
if (( $? == 0 )); then
	case $opcao in
       		1) versionrhela5 ;;
     		2) exit ;;
	esac
elif (( $? == 1 )); then
	versionrhel
else	
	exit
fi
}
function rhel6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                               \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "fping-3.9-1.el6.rf.x86_64.rpm" > /zabbix/.config/var/fpingrpm.txt; echo "libevent-1.4.13-4.el6.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "unixODBC-2.2.14-14.el6.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; echo "ius-release-1.0-15.ius.el6.noarch.rpm" > /zabbix/.config/var/phprpm.txt; echo "epel-release-6-8.noarch.rpm" > /zabbix/.config/var/epelrpm.txt; versionrhels6 ;;
                2) echo "fping-3.9-1.el6.rf.x86_64.rpm" > /zabbix/.config/var/fpingrpm.txt; echo "libevent-1.4.13-4.el6.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "unixODBC-2.2.14-14.el6.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; versionrhelp6 ;;
                3) versionrhela6 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versionrhel
else
        exit
fi
}
function rhel7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                               \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "fping-3.10-1.el7.rf.x86_64.rpm" > /zabbix/.config/var/fpingrpm.txt; echo "libevent-2.0.21-4.el7.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "unixODBC-2.3.1-11.el7.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; echo "ius-release-1.0-15.ius.el7.noarch.rpm" > /zabbix/.config/var/phprpm.txt; echo "epel-release-7-11.noarch.rpm" > /zabbix/.config/var/epelrpm.txt; versionrhels7 ;;
                2) echo "fping-3.10-1.el7.rf.x86_64.rpm" > /zabbix/.config/var/fpingrpm.txt; echo "libevent-2.0.21-4.el7.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "unixODBC-2.3.1-11.el7.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; versionrhelp7 ;;
                3) versionrhela7 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versionrhel
else
        exit
fi
}
function versionrhela5(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair" )
if (( $? == 0 )); then
	case $opcao in
        	1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versiona530 ;;
       		2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versiona534 ;;
        	3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versiona540 ;;
		4) exit ;;
	esac
elif (( $? == 1 )); then
        rhel5
else
	exit
fi
}
function versionrhela6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versiona630 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versiona634 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versiona640 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        rhel6
else
        exit
fi
}
function versionrhela7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair" )      
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versiona730 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versiona734 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versiona740 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        rhel7
else
        exit
fi
}
function versionrhels6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versions630 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versions634 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versions640 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        rhel6
else
        exit
fi
}
function versionrhels7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versions730 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versions734 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versions740 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        rhel7
else
        exit
fi
}
function versionrhelp6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versionp630 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versionp634 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versionp640 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        rhel6
else
        exit
fi
}
function versionrhelp7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versionp730 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versionp734 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versionp740 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        rhel7
else
        exit
fi
}
function versions630(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0-1.el6.noarch.rpm"                                 \
        2 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0-1.el6.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxxs;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionrhels6
else
        exit
fi
}
function versions730(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0-1.el7.noarch.rpm"                                 \
        2 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0-1.el7.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxxs;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionrhels7
else
        exit
fi
}
function versions634(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.4-1.el6.noarch.rpm"                                 \
        2 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4-1.el6.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxxs;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionrhels6
else
        exit
fi
}
function versions734(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.4-1.el7.centos.noarch.rpm"                                 \
        2 "3.4-2.el7.noarch.rpm"                                 \
        3 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4-1.el7.centos.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxxs;;
                        2) echo "3.4-2.el7.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxxs;;
                        3) exit;;
        esac
elif (( $? == 1 )); then
        versionrhels7
else
        exit
fi
}
function versions640(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "4.0-1.el6.noarch.rpm"                                 \
        2 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0-1.el6.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxxs;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionrhels6
else
        exit
fi
}
function versions740(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "4.0-1.el7.noarch.rpm"                                 \
        2 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0-1.el7.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxxs;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionrhels7
else
        exit
fi
}
function versionp630(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0.0-2.el6.x86_64.rpm"                                 \
        2 "3.0.1-1.el6.x86_64.rpm"                                 \
        3 "3.0.1-2.el6.x86_64.rpm"                                \
        4 "3.0.2-1.el6.x86_64.rpm"                                \
        5 "3.0.11-1.el6.x86_64.rpm"                                \
        6 "3.0.12-1.el6.x86_64.rpm"                                \
        7 "3.0.13-1.el6.x86_64.rpm"                                \
        8 "3.0.13-2.el6.x86_64.rpm"                                \
        9 "3.0.14-1.el6.x86_64.rpm"      \
        10 "3.0.15-1.el6.x86_64.rpm"       \
        11 "3.0.16-1.el6.x86_64.rpm"        \
        12 "3.0.17-1.el6.x86_64.rpm"         \
        13 "3.0.18-1.el6.x86_64.rpm"           \
        14 "3.0.19-1.el6.x86_64.rpm"            \
        15 "3.0.2-1.el6.x86_64.rpm"        \
        16 "3.0.20-1.el6.x86_64.rpm"         \
        17 "3.0.21-1.el6.x86_64.rpm"        \
        18 "3.0.22-1.el6.x86_64.rpm"              \
        19 "3.0.23-1.el6.x86_64.rpm"               \
        20 "3.0.24-1.el6.x86_64.rpm"               \
        21 "3.0.3-1.el6.x86_64.rpm"                \
        22 "3.0.4-1.el6.x86_64.rpm"                \
        23 "3.0.5-1.el6.x86_64.rpm"                 \
        24 "3.0.6-1.el6.x86_64.rpm"                \
        25 "3.0.7-1.el6.x86_64.rpm"                 \
        26 "3.0.8-1.el6.x86_64.rpm"     \
        27 "3.0.9-1.el6.x86_64.rpm"        \
        28 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.1-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.0.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                       	7) echo "3.0.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.13-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.16-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.17-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.18-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.19-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.20-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.21-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.22-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.23-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.24-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) echo "3.0.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        28) exit;;
        esac
	selinuxxp
elif (( $? == 1 )); then
        versionrhelp6
else
        exit
fi
}
function versionp730(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0.0-1.el7.x86_64.rpm"                                 \
        2 "3.0.1-1.el7.x86_64.rpm"                                 \
        3 "3.0.10-1.el7.x86_64.rpm"                                \
        4 "3.0.11-1.el7.x86_64.rpm"                                \
        5 "3.0.12-1.el7.x86_64.rpm"                                \
        6 "3.0.13-1.el7.x86_64.rpm"                                \
        7 "3.0.13-2.el7.x86_64.rpm"                                \
        8 "3.0.14-1.el7.x86_64.rpm"      \
        9 "3.0.15-1.el7.x86_64.rpm"       \
        10 "3.0.16-1.el7.x86_64.rpm"        \
        11 "3.0.17-1.el7.x86_64.rpm"         \
        12 "3.0.18-1.el7.x86_64.rpm"           \
        13 "3.0.19-1.el7.x86_64.rpm"            \
        14 "3.0.2-1.el7.x86_64.rpm"        \
        15 "3.0.20-1.el7.x86_64.rpm"         \
        16 "3.0.21-1.el7.x86_64.rpm"        \
        17 "3.0.22-1.el7.x86_64.rpm"              \
        18 "3.0.23-1.el7.x86_64.rpm"               \
        19 "3.0.24-1.el7.x86_64.rpm"               \
        20 "3.0.3-1.el7.x86_64.rpm"                \
        21 "3.0.4-1.el7.x86_64.rpm"                \
        22 "3.0.5-1.el7.x86_64.rpm"                 \
        23 "3.0.6-1.el7.x86_64.rpm"                \
        24 "3.0.7-1.el7.x86_64.rpm"                 \
        25 "3.0.8-1.el7.x86_64.rpm"     \
        26 "3.0.8-2.el7.x86_64.rpm"     \
        27 "3.0.9-1.el7.x86_64.rpm"        \
        28 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                       	6) echo "3.0.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.0.13-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.16-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.17-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.18-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.19-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.20-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.21-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.22-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.23-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.24-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.8-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) echo "3.0.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        28) exit;;
        esac
	selinuxxp
elif (( $? == 1 )); then
        versionrhelp7
else
        exit
fi
}
function versionp634(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
	1 "3.4.0-1.el6.x86_64.rpm"                                 \
        2 "3.4.1-1.el6.x86_64.rpm"					\
	3 "3.4.10-1.el6.x86_64.rpm"				\
	4 "3.4.11-1.el6.x86_64.rpm"				\
	5 "3.4.12-1.el6.x86_64.rpm"				\
	6 "3.4.13-1.el6.x86_64.rpm"				\
	7 "3.4.14-1.el6.x86_64.rpm"				\
	8 "3.4.15-1.el6.x86_64.rpm"				\
	9 "3.4.2-1.el6.x86_64.rpm"					\
	10 "3.4.3-1.el6.x86_64.rpm"				\
	11 "3.4.4-1.el6.x86_64.rpm"				\
	12 "3.4.4-2.el6.x86_64.rpm"				\
	13 "3.4.5-1.el6.x86_64.rpm"				\
	14 "3.4.6-1.el6.x86_64.rpm"				\
	15 "3.4.7-1.el6.x86_64.rpm"				\
	16 "3.4.8-1.el6.x86_64.rpm"				\
	17 "3.4.9-1.el6.x86_64.rpm"				\
	18 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) exit;;
        esac
	selinuxxp
elif (( $? == 1 )); then
        versionrhelp6
else
        exit
fi
}
function versionp734(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.4.0-1.el7.x86_64.rpm"                                 \
        2 "3.4.1-1.el7.x86_64.rpm"                                 \
        3 "3.4.10-1.el7.x86_64.rpm"                                \
        4 "3.4.11-1.el7.x86_64.rpm"                                \
        5 "3.4.12-1.el7.x86_64.rpm"                                \
        6 "3.4.13-1.el7.x86_64.rpm"                                \
        7 "3.4.14-1.el7.x86_64.rpm"                                \
        8 "3.4.15-1.el7.x86_64.rpm"                                \
        9 "3.4.2-1.el7.x86_64.rpm"                                 \
        10 "3.4.3-1.el7.x86_64.rpm"                                \
        11 "3.4.4-1.el7.x86_64.rpm"                                \
        12 "3.4.4-2.el7.x86_64.rpm"                                \
        13 "3.4.5-1.el7.x86_64.rpm"                                \
        14 "3.4.6-1.el7.x86_64.rpm"                                \
        15 "3.4.7-1.el7.x86_64.rpm"                                \
        16 "3.4.8-0.el7.x86_64.rpm"                                \
        17 "3.4.8-1.el7.x86_64.rpm"                                \
        18 "3.4.9-1.el7.x86_64.rpm"                                \
        19 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-0.0.1r80210.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.4.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) exit;;
        esac
	selinuxxp
elif (( $? == 1 )); then
        versionrhelp7
else
        exit
fi
}
function versionp640(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "4.0.0-2.el6.x86_64.rpm"                                 \
        2 "4.0.1-1.el6.x86_64.rpm"                                 \
        3 "4.0.2-1.el6.x86_64.rpm"                                \
        4 "4.0.3-1.el6.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;	
        esac
	selinuxxp
elif (( $? == 1 )); then
        versionrhelp6
else
        exit
fi
}
function versionp740(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "4.0.0-2.el7.x86_64.rpm"                                 \
        2 "4.0.1-1.el7.x86_64.rpm"                                 \
        3 "4.0.2-1.el7.x86_64.rpm"                                \
        4 "4.0.3-1.el7.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;
        esac
	selinuxxp
elif (( $? == 1 )); then
        versionrhelp7
else
        exit
fi
}
function versiona530(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
	1 "3.0.0-2.el5.x86_64.rpm"				 	\
	2 "3.0.1-2.el5.x86_64.rpm" 3 "3.0.10-1.el5.x86_64.rpm" 4 "3.0.11-1.el5.x86_64.rpm" 5 "3.0.12-1.el5.x86_64.rpm" 6 "3.0.13-1.el5.x86_64.rpm" 7 "3.0.13-2.el5.x86_64.rpm" 8 "3.0.14-1.el5.x86_64.rpm" 9 "3.0.15-1.el5.x86_64.rpm" 10 "3.0.16-1.el5.x86_64.rpm" 11 "3.0.17-1.el5.x86_64.rpm" 12 "3.0.18-1.el5.x86_64.rpm" 13 "3.0.19-1.el5.x86_64.rpm" 14 "3.0.2-1.el5.x86_64.rpm" 15 "3.0.20-1.el5.x86_64.rpm" 16 "3.0.21-1.el5.x86_64.rpm" 17 "3.0.22-1.el5.x86_64.rpm" 18 "3.0.23-1.el5.x86_64.rpm" 19 "3.0.24-1.el5.x86_64.rpm" 20 "3.0.3-1.el5.x86_64.rpm" 21 "3.0.4-1.el5.x86_64.rpm" 22 "3.0.5-1.el5.x86_64.rpm" 23 "3.0.6-1.el5.x86_64.rpm" 24 "3.0.7-1.el5.x86_64.rpm" 25 "3.0.8-1.el5.x86_64.rpm"	26 "3.0.9-1.el5.x86_64.rpm" 27 "Sair")
if (( $? == 0 )); then
        case $opcao in      
			1) echo "3.0.0-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			2) echo "3.0.1-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			3) echo "3.0.10-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			4) echo "3.0.11-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			5) echo "3.0.12-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;; 
			6) echo "3.0.13-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			7) echo "3.0.13-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			8) echo "3.0.14-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			9) echo "3.0.15-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			10) echo "3.0.16-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;        
			11) echo "3.0.17-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			12) echo "3.0.18-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			13) echo "3.0.19-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			14) echo "3.0.2-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			15) echo "3.0.20-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			16) echo "3.0.21-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			17) echo "3.0.22-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			18) echo "3.0.23-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			19) echo "3.0.24-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			20) echo "3.0.3-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			21) echo "3.0.4-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			22) echo "3.0.5-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			23) echo "3.0.6-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			24) echo "3.0.7-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			25) echo "3.0.8-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			26) echo "3.0.9-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			27) exit;;
        esac
	bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela5
else
        exit
fi
}
function versiona630(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0.0-2.el6.x86_64.rpm"                                 \
        2 "3.0.1-1.el6.x86_64.rpm"                                 \
        3 "3.0.1-2.el6.x86_64.rpm"                                    \
        4 "3.0.10-1.el6.x86_64.rpm"                                 \
        5 "3.0.11-1.el6.x86_64.rpm"                                \
        6 "3.0.12-1.el6.x86_64.rpm"                        \
        7 "3.0.13-1.el6.x86_64.rpm"    \
        8 "3.0.13-2.el6.x86_64.rpm"     \
        9 "3.0.14-1.el6.x86_64.rpm"      \
        10 "3.0.15-1.el6.x86_64.rpm"       \
        11 "3.0.16-1.el6.x86_64.rpm"        \
        12 "3.0.17-1.el6.x86_64.rpm"         \
        13 "3.0.18-1.el6.x86_64.rpm"           \
        14 "3.0.19-1.el6.x86_64.rpm"            \
        15 "3.0.2-1.el6.x86_64.rpm"        \
        16 "3.0.20-1.el6.x86_64.rpm"         \
        17 "3.0.21-1.el6.x86_64.rpm"        \
        18 "3.0.22-1.el6.x86_64.rpm"              \
        19 "3.0.23-1.el6.x86_64.rpm"               \
        20 "3.0.24-1.el6.x86_64.rpm"               \
        21 "3.0.3-1.el6.x86_64.rpm"                \
        22 "3.0.4-1.el6.x86_64.rpm"                \
        23 "3.0.5-1.el6.x86_64.rpm"                 \
        24 "3.0.6-1.el6.x86_64.rpm"                \
        25 "3.0.7-1.el6.x86_64.rpm"                 \
        26 "3.0.8-1.el6.x86_64.rpm"     \
        27 "3.0.9-1.el6.x86_64.rpm"        \
        28 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.1-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.0.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                       	7) echo "3.0.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.13-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.16-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.17-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.18-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.19-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.20-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.21-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.22-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.23-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.24-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) echo "3.0.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        28) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela6
else
        exit
fi

}
function versiona730(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0.0-2.el7.x86_64.rpm"                                 \
        2 "3.0.1-1.el7.x86_64.rpm"                                 \
        3 "3.0.10-1.el7.x86_64.rpm"                                 \
        4 "3.0.11-1.el7.x86_64.rpm"                                \
        5 "3.0.12-1.el7.x86_64.rpm"                        \
        6 "3.0.13-1.el7.x86_64.rpm"    \
        7 "3.0.13-2.el7.x86_64.rpm"     \
        8 "3.0.14-1.el7.x86_64.rpm"      \
        9 "3.0.15-1.el7.x86_64.rpm"       \
        10 "3.0.16-1.el7.x86_64.rpm"        \
        11 "3.0.17-1.el7.x86_64.rpm"         \
        12 "3.0.18-1.el7.x86_64.rpm"           \
        13 "3.0.19-1.el7.x86_64.rpm"            \
        14 "3.0.2-1.el7.x86_64.rpm"        \
        15 "3.0.20-1.el7.x86_64.rpm"         \
        16 "3.0.21-1.el7.x86_64.rpm"        \
        17 "3.0.22-1.el7.x86_64.rpm"              \
        18 "3.0.23-1.el7.x86_64.rpm"               \
        19 "3.0.24-1.el7.x86_64.rpm"               \
        20 "3.0.3-1.el7.x86_64.rpm"                \
        21 "3.0.4-1.el7.x86_64.rpm"                \
        22 "3.0.5-1.el7.x86_64.rpm"                 \
        23 "3.0.6-1.el7.x86_64.rpm"                \
        24 "3.0.7-1.el7.x86_64.rpm"                 \
        25 "3.0.8-1.el7.x86_64.rpm"     \
        26 "3.0.9-1.el7.x86_64.rpm"        \
        27 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.0.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.0.13-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.16-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.17-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.18-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.19-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.20-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.21-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.22-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.23-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.24-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela7
else
        exit
fi

}
function versiona534(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.4.0-1.el5.x86_64.rpm"                                
	2 "3.4.1-1.el5.x86_64.rpm" 3 "3.4.10-1.el5.x86_64.rpm" 4 "3.4.11-1.el5.x86_64.rpm" 5 "3.4.12-1.el5.x86_64.rpm" 6 "3.4.13-1.el5.x86_64.rpm" 7 "3.4.14-1.el5.x86_64.rpm" 8 "3.4.15-1.el5.x86_64.rpm" 9 "3.4.2-1.el5.x86_64.rpm" 10 "3.4.3-1.el5.x86_64.rpm" 11 "3.4.4-1.el5.x86_64.rpm" 12 "3.4.4-2.el5.x86_64.rpm" 13 "3.4.5-1.el5.x86_64.rpm" 14 "3.4.6-1.el5.x86_64.rpm" 15 "3.4.7-1.el5.x86_64.rpm" 16 "3.4.8-1.el5.x86_64.rpm" 17 "3.4.9-1.el5.x86_64.rpm" 18 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.9-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela5
else
        exit
fi
}
function versiona634(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
	1 "3.4.0-1.el6.x86_64.rpm"                                 \
        2 "3.4.1-1.el6.x86_64.rpm"					\
	3 "3.4.10-1.el6.x86_64.rpm"				\
	4 "3.4.11-1.el6.x86_64.rpm"				\
	5 "3.4.12-1.el6.x86_64.rpm"				\
	6 "3.4.13-1.el6.x86_64.rpm"				\
	7 "3.4.14-1.el6.x86_64.rpm"				\
	8 "3.4.15-1.el6.x86_64.rpm"				\
	9 "3.4.2-1.el6.x86_64.rpm"					\
	10 "3.4.3-1.el6.x86_64.rpm"				\
	11 "3.4.4-1.el6.x86_64.rpm"				\
	12 "3.4.4-2.el6.x86_64.rpm"				\
	13 "3.4.5-1.el6.x86_64.rpm"				\
	14 "3.4.6-1.el6.x86_64.rpm"				\
	15 "3.4.7-1.el6.x86_64.rpm"				\
	16 "3.4.8-1.el6.x86_64.rpm"				\
	17 "3.4.9-1.el6.x86_64.rpm"				\
	18 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela6
else
        exit
fi
}
function versiona734(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.4.0-1.el7.x86_64.rpm"                                 \
        2 "3.4.1-1.el7.x86_64.rpm"                                 \
        3 "3.4.10-1.el7.x86_64.rpm"                                \
        4 "3.4.11-1.el7.x86_64.rpm"                                \
        5 "3.4.12-1.el7.x86_64.rpm"                                \
        6 "3.4.13-1.el7.x86_64.rpm"                                \
        7 "3.4.14-1.el7.x86_64.rpm"                                \
        8 "3.4.15-1.el7.x86_64.rpm"                                \
        9 "3.4.2-1.el7.x86_64.rpm"                                 \
        10 "3.4.3-1.el7.x86_64.rpm"                                \
        11 "3.4.4-1.el7.x86_64.rpm"                                \
        12 "3.4.4-2.el7.x86_64.rpm"                                \
        13 "3.4.5-1.el7.x86_64.rpm"                                \
        14 "3.4.6-1.el7.x86_64.rpm"                                \
        15 "3.4.7-1.el7.x86_64.rpm"                                \
        16 "3.4.8-0.el7.x86_64.rpm"                                \
        17 "3.4.8-1.el7.x86_64.rpm"                                \
        18 "3.4.9-1.el7.x86_64.rpm"                                \
        19 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-0.0.1r80210.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.4.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela7
else
        exit
fi
}
function versiona540(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "4.0.0-2.el5.x86_64.rpm"                                 \
        2 "4.0.1-1.el5.x86_64.rpm"                                 \
        3 "4.0.2-1.el5.x86_64.rpm"                                \
        4 "4.0.3-1.el5.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela5
else
        exit
fi
}
function versiona640(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "4.0.0-2.el6.x86_64.rpm"                                 \
        2 "4.0.1-1.el6.x86_64.rpm"                                 \
        3 "4.0.2-1.el6.x86_64.rpm"                                \
        4 "4.0.3-1.el6.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;	
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela6
else
        exit
fi
}
function versiona740(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "4.0.0-2.el7.x86_64.rpm"                                 \
        2 "4.0.1-1.el7.x86_64.rpm"                                 \
        3 "4.0.2-1.el7.x86_64.rpm"                                \
        4 "4.0.3-1.el7.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionrhela7
else
        exit
fi
}
function helpso(){
cat /etc/*-release | grep PRETTY_NAME | cut -d= -f 2 > /zabbix/.config/var/seuso.txt
dialog --backtitle "LRS Tecnologia LTDA" --title "Seu Sistema Operacional" --tailbox /zabbix/.config/var/seuso.txt 0 0
if (( $? == 0 )); then
	menu
else
	exit
fi
}
function helpversion(){
cat /etc/*-release | grep VERSION | cut -d= -f 2 > /zabbix/.config/var/seuso.txt
dialog --backtitle "LRS Tecnologia LTDA" --title "Sua Versão" --tailbox /zabbix/.config/var/seuso.txt 0 0
if (( $? == 0 )); then
	menu
else
	exit
fi
}
function selinuxxs(){
setenforce 0
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config
bash /zabbix/.config/rhel/zabbix-server.sh
}
function selinuxxp(){
setenforce 0
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config
bash /zabbix/.config/rhel/zabbix-proxy.sh
}
function versiondebian(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Debian:"            \
        0 0 0                                           \
        1 "7 (Wheezy)"                                           \
        2 "8 (Jessie)"                                           \
        3 "9 (Stretch)"                                           \
        4 "Não sei minha versão"                       \
        5 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) debian7;;
                2) debian8;;
                3) debian9;;
                4) helpversion ;;
                5) exit ;;
        esac
elif (( $? == 1 )); then
        menu
else
        exit
fi
}
function debian7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                                \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) diretorio=1; versiondebian7 ;;
                2) diretorio=2; versiondebian7 ;;
                3) diretorio=3; versiondebian7 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versiondebian
else
        exit
fi
}
function debian8(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                                \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) diretorio=1; versiondebian8 ;;
                2) diretorio=2; versiondebian8 ;;
                3) diretorio=3; versiondebian8 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versiondebian
else
        exit
fi
}
function debian9(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                                \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) diretorio=1; versiondebian9 ;;
                2) diretorio=2; versiondebian9 ;;
                3) diretorio=3; versiondebian9 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versiondebian
else
        exit
fi
}
function versiondebian7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix:"    \
        0 0 0                                           \
        1 "3.0-1"                                           \
        2 "3.0-2"                                           \
        3 "3.4-1"                                           \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-1+wheezy_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                2) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-2+wheezy_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                3) echo "3.4" > /zabbix/.config/var/versionprimary.txt; echo "3.4-1+wheezy_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                4) exit ;;
        esac
	debiandiretorio
elif (( $? == 1 )); then
        debian7
else
        exit
fi
}
function versiondebian8(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix:"    \
        0 0 0                                           \
        1 "3.0-1"                                           \
        2 "3.0-2"                                           \
        3 "3.4-1"                                           \
        4 "4.0-1"                                           \
        5 "4.0-2"                                           \
        6 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-1+jessie_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                2) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-2+jessie_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                3) echo "3.4" > /zabbix/.config/var/versionprimary.txt; echo "3.4-1+jessie_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                4) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-1+jessie_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                5) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-2+jessie_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                6) exit ;;
        esac
	debiandiretorio
elif (( $? == 1 )); then
        debian8
else
        exit
fi
}
function versiondebian9(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix:"    \
        0 0 0                                           \
        1 "3.0-2"                                           \
        2 "3.4-1"                                           \
        3 "4.0-1"                                           \
        4 "4.0-2"                                           \
        5 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-2+stretch_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; echo "3.4-1+stretch_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-1+stretch_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                4) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-2+stretch_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                5) exit ;;
        esac
	debiandiretorio
elif (( $? == 1 )); then
        debian9
else
        exit
fi
}
function versionubuntu(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Ubuntu:"            \
        0 0 0                                           \
	1 "14.04 (Trusty)"                                           \
	2 "16.04 (Xenial)"                                           \
	3 "18.04 (Bionic)"                                           \
        4 "Não sei minha versão"                       \
        5 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) ubuntu14;;
                2) ubuntu16;;
                3) ubuntu18;;
                4) helpversion ;;
                5) exit ;;
        esac
elif (( $? == 1 )); then
        menu
else
        exit
fi
}
function ubuntu14(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                                \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) diretorio=1; versionubuntu14 ;;
                2) diretorio=2; versionubuntu14 ;;
                3) diretorio=3; versionubuntu14 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versionubuntu
else
        exit
fi
}
function ubuntu16(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                                \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) diretorio=1; versionubuntu16 ;;
                2) diretorio=2; versionubuntu16 ;;
                3) diretorio=3; versionubuntu16 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versionubuntu
else
        exit
fi
}
function ubuntu18(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                                \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) diretorio=1; versionubuntu18 ;;
                2) diretorio=2; versionubuntu18 ;;
                3) diretorio=3; versionubuntu18 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versionubuntu
else
        exit
fi
}
function versionubuntu14(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix:"    \
        0 0 0                                           \
        1 "3.0-1"                                           \
        2 "3.0-2"                                           \
        3 "3.4-1"                                           \
        4 "4.0-1"                                           \
        5 "4.0-2"                                           \
        6 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-1+trusty_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                2) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-2+trusty_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                3) echo "3.4" > /zabbix/.config/var/versionprimary.txt; echo "3.4-1+trusty_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                4) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-1+trusty_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                5) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-2+trusty_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                6) exit ;;
        esac
        debiandiretorio
elif (( $? == 1 )); then
        ubuntu14
else
        exit
fi
}
function versionubuntu16(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix:"    \
        0 0 0                                           \
        1 "3.0-1"                                           \
        2 "3.0-2"                                           \
        3 "3.4-1"                                           \
        4 "4.0-1"                                           \
        5 "4.0-2"                                           \
        6 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-1+xenial_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                2) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-2+xenial_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                3) echo "3.4" > /zabbix/.config/var/versionprimary.txt; echo "3.4-1+xenial_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                4) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-1+xenial_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                5) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-2+xenial_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                6) exit ;;
        esac
        debiandiretorio
elif (( $? == 1 )); then
        ubuntu16
else
        exit
fi
}
function versionubuntu18(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix:"    \
        0 0 0                                           \
        1 "3.0-1"                                           \
        2 "3.0-2"                                           \
        3 "3.4-1"                                           \
        4 "4.0-1"                                           \
        5 "4.0-2"                                           \
        6 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-1+bionic_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                2) echo "3.0" > /zabbix/.config/var/versionprimary.txt; echo "3.0-2+bionic_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                3) echo "3.4" > /zabbix/.config/var/versionprimary.txt; echo "3.4-1+bionic_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                4) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-1+bionic_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                5) echo "4.0" > /zabbix/.config/var/versionprimary.txt; echo "4.0-2+bionic_all.deb" > /zabbix/.config/var/versionzbx.txt;;
                6) exit ;;
        esac
        debiandiretorio
elif (( $? == 1 )); then
	ubuntu18
else
        exit
fi
}

function debiandiretorio(){
case $diretorio in
	1) bash /zabbix/.config/debian/zabbix-server.sh;;
	2) bash /zabbix/.config/debian/zabbix-proxy.sh;;
	3) bash /zabbix/.config/debian/zabbix-agent.sh;;
esac
}
menu
