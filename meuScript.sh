#!/bin/bash

# Atualizando o sistema
sudo yum update -y | tee -a /var/log/setup-script.log

# Instalando o Apache (httpd no Amazon Linux 2)
sudo yum install -y httpd git curl | tee -a /var/log/setup-script.log

# Iniciando e habilitando o serviço do Apache
sudo systemctl start httpd | tee -a /var/log/setup-script.log
sudo systemctl enable httpd | tee -a /var/log/setup-script.log

# Clonando o repositório
git clone https://github.com/jnrxvr/desafioShell.git /var/www/html/desafioShell | tee -a /var/log/setup-script.log

# Movendo os arquivos do repositório para a pasta do site
sudo mv /var/www/html/desafioShell/* /var/www/html/ | tee -a /var/log/setup-script.log

# Reiniciando o serviço do Apache
sudo systemctl restart httpd | tee -a /var/log/setup-script.log

# Enviando solicitação POST ao site difusão.tech
curl -X POST -d "nome=Junior Xavier" https://difusaotech.com.br/lab/aws/index.php | tee -a /var/log/setup-script.log

# Fim do script
echo "Script executado com sucesso!" >> /var/log/setup-script.log
