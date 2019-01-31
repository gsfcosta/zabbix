instalação automática

Requisitos:

1) Sistema Operacional
Rhel (CentOS ou RedHat): el5 - el6 - el7
Debian: 7 (Wheezy) - 8 (Jessie) - 9 (Stretch)
Ubuntu: 14.04 (Trusty) - 16.04 (Xenial) - 18.04 (Bionic)
Suse: sles 12

2) Ter acesso a internet e estar logado com o usuário ROOT.

3) Garanta que os repositórios estejam configurados corretamente (principalmente para instalar o Banco de dados: mariadb)

4) Instalar dependiancias: web (apache2 ou httpd) - wget - git



############################################################################################

Instalação:

1) Acesse a raiz do linux:
# cd /

2) Com o usuário ROOT, faça o download do git:
# git clone https://github.com/gsfcosta/zabbix.git

3) Acessa a pasta baixada:
# cd /zabbix

4) Dê permissão total (ou apenas de execução) para todos os arquivos:
# chmod 777 ./* -R
ou
# chmod 755 ./* -R

5) Execute o script:
./install.sh

6) Seleciona as opções referentes ao seu S.O e ao que deseja instalar. E durante a instalação fique de olhos nas informações que precisam ser preenchidas.

############################################################################################

Observações:

Na instalação do Zabbix Server e Proxy, será solicitade que crie uma senha do root do banco de dados ou que utilize a senha ja existente.
Caso esteja instalando em uma máquina recém instalada, e não tenha banco de dados instalado ou configurado, selecione a segunda opção: Criar nova senha.


Durante a instalação em uma distribuição Rhel (RedHat ou CentOS) será desativado o SElinux para ter um sucesso na instação.

Durante a instalação será limpado as regras ativas do iptables. Por isso, salve suas regras filter em um lugar seguro.

############################################################################################

Tire bom proveito.

Por favor, me dê sugestões sobre o que melhorar no script, assim como bugs e erros que ocorrem durante a instalação!

Obrigado!

Desenvolvedor:
Gabriel Silva

