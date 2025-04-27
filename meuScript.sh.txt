#! /bin/bash

# Diretório dos logs
logs="/var/log/user_data.log" # define a variável "logs" com o caminho do arquivo de log
echo "Início da execução do script..." > $logs # escreve a mensagem na variável "logs" (arquivo de log)

# Atualizando o sistema Amazon Linux
echo "Atualizando o sistema..." | tee -a $logs # redireciona a mensagem ao arquivo de log, sem deixar de exibi-la no terminal
sudo yum update -y >> $logs 2>&1 # redireciona a saída do comando para ser escrita no arquivo de log

# Instalando o Apache
echo "Instalando o servidor Apache..." | tee -a $logs
sudo yum install -y httpd >> $logs 2>&1

# Ativando o serviço do servidor apache
echo "Ativando o serviço do servidor Apache no sistema..." | tee -a $logs
systemctl start httpd >> $logs 2>&1 # inicializa o serviço do servidor apache
systemctl enable httpd >> $logs 2>&1 # ativa o serviço do servidor apache para iniciar automaticamente no boot

# instalando o git 
echo "Instalando o git no sistema..." | tee -a $logs
sudo yum install -y git >> $logs 2>&1

# Clonando o repositório Git
echo "Clonando repositório GitHub..." | tee -a $logs

if sudo git clone https://github.com/jnrxvr/desafioShell.git /tmp/meu-site >> $logs 2>&1; then
	echo "Clone realizado com sucesso!" | tee -a $logs

	# configurando o site e movendo o arquivo index para a pasta index 	do apache
	echo "Configurando site..." | tee -a $logs
	sudo mv /tmp/meu-site/index.html /var/www/html/ >> $logs 2>&1 # 	move o index.html do repositório para a pasta html do apache

	# Ajustando as permissões
	echo "Ajustando permissões..." | tee -a $logs
	sudo chmod -R 755 /var/www/html/ >> $logs 2>&1
	sudo chown -R apache:apache /var/www/html/ >> $logs 2>&1

	# Reiniciando o Apache e verificando o status do serviço
	echo "Reiniciando o Apache..." | tee -a $logs
	sudo systemctl restart httpd >> $logs 2>&1 # reinicia o serviço do 	apache

else
	echo  "Falha ao clonar repositório." | tee -a $logs
	exit 1
fi

# verificação final do status do serviço
echo "Verificando status do Apache..." | tee -a $logs
sudo systemctl status httpd >> $logs 2>&1

# Enviando solicitação POST
echo "Enviando solicitação POST..." | tee -a $logs # envia uma solicitação de postagem ao site difusaotech
curl -X POST -d "nome=Junior do Nascimento Xavier" https://difusaotech.com.br/lab/aws/index.php >> $logs 2>&1 

echo "Fim do script!" | tee -a $logs