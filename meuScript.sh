#!/bin/bash

# atualizando o sistema
sudo apt update -y | tee -a /var/log/setup-script.log
sudo apt upgrade -y | tee -a /var/log/setup-script.log

# instalando o apache
sudo apt install apache2 -y | tee -a /var/log/setup-script.log

# clonando o repositório
git clone https://github.com/jnrxvr/desafioShell.git /var/www/html/desafioShell | tee -a /var/log/setup-script.log

sudo mv /var/www/html/desafioShell/* /var/www/html | tee -a /var/log/setup-script.log

sudo systemctl restart apache2 | tee -a /var/log/setup-script.log
 # reiniciando o serviço do apache2

# enviando solicitação POST ao site difusão.tech
curl -X POST -d "nome=Junior Xavier" https://difusaotech.com.br/lab/aws/index.php | tee -a /var/log/setup-script.log

# fim do script
echo "Script executado com sucesso!" >> /var/log/setup-script.log
