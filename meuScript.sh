#! /bin/bash

# Diretório dos logs
logs="/var/log/user_data.log"
echo "Início da execução do script..." > $logs # escreve a mensagem na variável "logs" (arquivo de log)

# Atualizando o sistema Amazon Linux
echo "[ETAPA 1/10] Atualizando o sistema..." | tee -a $logs # redireciona a mensagem ao arquivo de log, sem deixar de exibi-la no terminal
sudo yum update -y >> $logs 2>&1 # redireciona a saída do comando para ser escrita no arquivo de log

# Instalando o Apache
echo "[ETAPA 2/10] Instalando o servidor Apache..." | tee -a $logs
sudo yum install -y apache2 >> $logs 2>&1

# Ativando o serviço do servidor apache
echo "[ETAPA 3/10] Ativando o serviço do servidor Apache no sistema..." | tee -a $logs
sudo systemctl start apache2 >> $logs 2>&1 # inicializa o serviço do servidor apache
sudo systemctl enable apache2 >> $logs 2>&1 # ativa o serviço do servidor apache para iniciar automaticamente no boot

# instalando o git 
echo "[ETAPA 4/10] Instalando o git no sistema..." | tee -a $logs
sudo yum install -y git >> $logs 2>&1

# Clonando o repositório Git
echo "[ETAPA 5/10] Clonando repositório GitHub..." | tee -a $logs
sudo git clone https://github.com/jnrxvr/desafioShell.git /tmp/meu-site >> $logs 2>&1 
# configurando o site e movendo o arquivo index para a pasta index do apache
echo "[ETAPA 6/10] Configurando site..." | tee -a $logs
sudo mv /tmp/meu-site/index.html /var/www/html/ >> $logs 2>&1 # move o index.html do repositório para a pasta html do apache

# Ajustando as permissões
echo "[ETAPA 7/10] Ajustando permissões..." | tee -a $logs
sudo chmod -R 755 /var/www/html/ >> $logs 2>&1

# Reiniciando o Apache e verificando o status do serviço
echo "[ETAPA 8/10] Reiniciando o Apache..." | tee -a $logs
sudo systemctl restart apache2 >> $logs 2>&1 # reinicia o serviço do apache


# verificação final do status do serviço
echo "[ETAPA 9/10] Verificando status do Apache..." | tee -a $logs
sudo systemctl status apache2 >> $logs 2>&1

# Enviando solicitação POST
echo "[ETAPA 10/10] Enviando solicitação POST para https://difusaotech.com.br/lab/aws/index.php" | tee -a $logs # envia uma solicitação de postagem ao site difusaotech
curl -X POST -d "nome=Junior Xavier" https://difusaotech.com.br/lab/aws/index.php >> $logs 2>&1 

echo "Fim do script!" | tee -a $logs
