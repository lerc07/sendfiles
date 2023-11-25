#!/bin/bash
# Autor: Luis Ramalho
# SendFiles.sh
# Envia arquivos da raiz para um servidor FTP, TFTP ou SSH/SCP do RouterOS
# Versão: 1.0
# Licenciado sob a GPL 3.0
# Função para verificar e instalar as dependências necessárias
verificar_e_instalar_dependencias() {
    local dependencies=("sshpass" "tftp" "dialog" "ftp")

    for dependency in "${dependencies[@]}"; do
        if ! command -v "$dependency" &>/dev/null; then
            echo "O pacote $dependency não está instalado. Instalando..."
            case $dependency in
                "sshpass")
                    sudo apt update
                    sudo apt install -y sshpass
                    ;;
                "tftp")
                    sudo apt update
                    sudo apt install -y tftp
                    ;;
                "dialog")
                    sudo apt update
                    sudo apt install -y dialog
                    ;;
                "ftp")
                    sudo apt update
                    sudo apt install -y ftp
                    ;;
                *)
                    echo "Pacote $dependency não reconhecido."
                    ;;
            esac
        fi
    done
}
# Verificar e instalar as dependências
verificar_e_instalar_dependencias

# Variaveis
bgtitulo="SendFILES - Envio de Arquivos para RouterOS - By LeRc - Ver.: 1.0"

send_via_ssh() {
    local ssh_target="$1"
    local ssh_user="$2"
    local local_file="$3"
    local ip=${ssh_target%:*}
    local port=${ssh_target##*:}
    echo "Enviando arquivo '$local_file' para $ssh_target..."
    sshpass -p "$(dialog --stdout --backtitle "$bgtitulo" \
            --title "Senha SSH" \
            --passwordbox "
Digite a senha SSH:" 10 45)" \
            scp -P "$port" "$local_file" "$ssh_user@$ip:"
    if [ $? -eq 0 ]; then
        resposta=$(dialog --stdout --backtitle "$bgtitulo" --title "Sucesso" --yesno "Arquivo '$local_file' enviado com sucesso para o dispositivo RouterOS ($ssh_target).
Deseja importar remotamente o arquivo?" 10 50)
        
        if [ $? -eq 0 ]; then
            echo "Você escolheu 'Sim'. Estabelecendo conexão SSH para importar o arquivo..."
            # Estabelecer a conexão SSH e executar o comando para importar o arquivo remotamente
            senha_ssh_import=$(dialog --stdout --backtitle "$bgtitulo" --title "Senha SSH" --passwordbox "
Digite a senha SSH para importar o arquivo remotamente:" 10 45)
            # Comando SSH para executar o import no dispositivo remoto
            sshpass -p "$senha_ssh_import" ssh -p "$port" "$ssh_user@$ip" "import file-name=$local_file"
            if [ $? -eq 0 ]; then
                echo "Arquivo '$local_file' importado com sucesso remotamente."
            else
                echo "Falha ao importar o arquivo '$local_file' remotamente."
            fi
        else
            echo "Você escolheu 'Não'. Encerrando o script."
            exit 0
        fi
    else
        echo "Falha ao enviar o arquivo '$local_file' para o dispositivo RouterOS ($ssh_target)."
    fi
}
# Função para enviar arquivo via TFTP
send_via_tftp() {
    local router_ip="$1"
    local file_to_send="$2"
    if [ ! -e "$file_to_send" ]; then
        echo "O arquivo '$file_to_send' não existe."
        exit 1
    fi
    echo "put $file_to_send" | tftp $router_ip
    if [ $? -eq 0 ]; then
        echo "Arquivo '$file_to_send' enviado com sucesso para o dispositivo RouterOS ($router_ip)."
    else
        echo "Falha ao enviar o arquivo '$file_to_send' para o dispositivo RouterOS ($router_ip)."
    fi
}
# Função para enviar arquivo via FTP
send_via_ftp() {
    local ftp_target="$1"
    local ftp_user="$2"
    local local_file="$3"
    # Solicitar a senha usando o dialog
    local ftp_password=$(dialog --stdout --backtitle "$bgtitulo" \
                        --title "Informações FTP" \
                        --passwordbox "
Digite a Senha FTP do Login: [$ftp_user]:" 10 45)
    echo "Enviando arquivo '$local_file' via FTP para $ftp_target..."
    # Criar um script temporário para o FTP com nome de usuário e senha
    local ftp_commands=$(mktemp)
    chmod +x "$ftp_commands"
    cat <<EOF > "$ftp_commands"
    quote USER $ftp_user
    quote PASS $ftp_password
    put $local_file
    quit
EOF
    ftp -n $ftp_target < "$ftp_commands"
    if [ $? -eq 0 ]; then
        echo "Arquivo '$local_file' enviado com sucesso para o dispositivo FTP ($ftp_target)."
    else
        echo "Falha ao enviar o arquivo '$local_file' para o dispositivo FTP ($ftp_target)."
    fi
    rm -f "$ftp_commands"  # Remover script temporário de comandos FTP
}
# Listar arquivos .rsc no diretório atual
arquivos_rsc=($(ls *.rsc 2>/dev/null))
if [ ${#arquivos_rsc[@]} -eq 0 ]; then
    echo "Nenhum arquivo .rsc encontrado no diretório atual."
    exit 1
fi
# Criar array de seleção para o dialog
declare -a arquivos_selecao=()
for arquivo in "${arquivos_rsc[@]}"; do
    arquivos_selecao+=("$arquivo" "" off)
done
# Diálogo para seleção do arquivo .rsc
escolha_arquivo=$(dialog --stdout --backtitle "$bgtitulo" \
    --title "Arquivos .rsc no diretorio raiz." \
    --radiolist "
	Selecione o arquivo .rsc:" 12 45 6 "${arquivos_selecao[@]}")
case "$escolha_arquivo" in
    "")
        echo "Nenhum arquivo selecionado."
        ;;
    *)
        # Diálogo para seleção do método de transferência
        escolha_metodo=$(dialog --stdout --backtitle "$bgtitulo" \
            --title "METODOS DE TRANSFERÊNCIA" \
            --radiolist "
Escolha o método de transferência:" 12 45 3 \
            "SSH" "Porta Ajustável" ON \
            "TFTP" "Porta Padrão: 69" OFF \
            "FTP" "Porta Padrão: 21" OFF)
        case "$escolha_metodo" in
            *SSH*)
                ssh_target=$(dialog --stdout --backtitle "$bgtitulo" \
                    --title "Informações SSH" \
                    --inputbox "
Digite o IP:porta do host 
Exemplo: 192.168.1.100:2200" 10 45 ":2200")
                ssh_user=$(dialog --stdout --backtitle "$bgtitulo" \
                    --title "Login SSH" \
                    --inputbox "
Digite o nome de usuário SSH:" 10 45)
                send_via_ssh "$ssh_target" "$ssh_user" "$escolha_arquivo"
                ;;
            *TFTP*)
                tftp_target=$(dialog --stdout --backtitle "$bgtitulo" \
                    --title "Informações TFTP" \
                    --inputbox "
Digite o IP do Servidor TFTP 
Exemplo: 192.168.1.100" 10 45)
                send_via_tftp "$tftp_target" "$escolha_arquivo"
                ;;
            *FTP*)
                ftp_target=$(dialog --stdout --backtitle "$bgtitulo" \
                    --title "Informações FTP" \
                    --inputbox "
Digite o IP Servidor FTP:
Exemplo: 192.168.1.100
A porta deve ser a 21." 10 45)
                ftp_user=$(dialog --stdout --backtitle "$bgtitulo" \
                    --title "Informações FTP" \
                    --inputbox "
Digite o Login FTP:" 10 45)
                send_via_ftp "$ftp_target" "$ftp_user" "$escolha_arquivo"
                ;;
            *)
                echo "Nenhum método selecionado."
                ;;
        esac
        ;;
esac
