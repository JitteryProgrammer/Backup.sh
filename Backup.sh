#!/bin/bash 

# Definir variáveis
DATA=`date +%Y-%m-%d`
ARQUIVO="backup-$data.tar.gz"

# Para que seu script funcione corretamente, é importante mudar as permissões de execução
# Permissões para todos
chmod +x nome_arquivo 

# Selecionando o diretório alvo e comprimindo os arquivos
cd /home 
tar -zcvf "$ARQUIVO" * 
 
# Verificando se o arquivo foi criado
if [ -f "$ARQUIVO" ]; then 

    # Enviando o arquivo por FTP para um servidor externo  
    ftp -n <<FINISH
    open meudebackup.noip.me 
    USER senhaBackup 
    lcd /home/ 
    cd backups 
    put "$ARQUIVO" 
    bye 
FINISH

    # Caso o backup seja realizado com sucesso, será exibido uma mensagem na tela: 
    echo "Backup realizado com sucesso para o servidor remoto"

    # Se o arquivo existir, mas o backup não for bem-sucedido, será exibida uma mensagem de erro.  
    else echo "Falha ao realizar o backup." fi
