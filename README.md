# sendfiles
Script para Enviar arquivos da Shell direto para um RouterOS via SSH, TFTP ou FTP.
---------------------------

Ferramenta criada como complemento para auxiliar no envio de arquivos de scripts.rsc gerados na shell e que estão localizados no mesmo diretório do script sendfiles.sh

A ferramenta permite:

- Selecionar 1 único arquivos de uma lista com extensão .rsc;
- Escolher o tipo de protocolo utilizado para envio do arquivo:
  - SSH
  - TFTP
  - FTP
- Informar o endereço IP do Servidor Remoto e porta (no caso de SSH).
- Porta padrão para TFTP(69) e FTP(21)

- Permite a importação remota via SSH do arquivo enviado para o RouterOS, solicitando a senha novamente para confirmação da importação.

Imagens
------------------------------

![image](https://github.com/lerc07/sendfiles/assets/151892038/26bc5733-0e0a-4cd4-bd47-d243da768778)
![image](https://github.com/lerc07/sendfiles/assets/151892038/c7a65056-caca-41d4-adce-c4cc322dae23)
![image](https://github.com/lerc07/sendfiles/assets/151892038/1e1fae7b-dd10-41d1-93b6-dc8a6b9c058d)
![image](https://github.com/lerc07/sendfiles/assets/151892038/e71e9874-1f9a-42bb-863b-8781241b8c29)
![image](https://github.com/lerc07/sendfiles/assets/151892038/c665c39d-f7ec-4a3f-ac1f-51268b6acdf5)
![image](https://github.com/lerc07/sendfiles/assets/151892038/c5db934e-7bb2-4a89-b617-0625e296399f)
![image](https://github.com/lerc07/sendfiles/assets/151892038/d053ff6a-fd77-49f8-a787-c7d56c2a0376)
![image](https://github.com/lerc07/sendfiles/assets/151892038/988596f6-2171-41ba-b7f2-d0f82d9c2227)

![image](https://github.com/lerc07/sendfiles/assets/151892038/bee04f37-6520-4d5f-883e-532da403bb52)

![image](https://github.com/lerc07/sendfiles/assets/151892038/1bd7dd57-3604-49e0-87fb-4c66dee64676)

------------------------
Ferramenta desenvolvida para utilizar em conjunto com o cgnatgen:

https://github.com/lerc07/cgnatgen

Agradecimento especial ao ChatGPT que ajudou em 70% no desenvolvimento. :D
 
