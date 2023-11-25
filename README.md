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

Imagens SSH
------------------------------

![image](https://github.com/lerc07/sendfiles/assets/151892038/26bc5733-0e0a-4cd4-bd47-d243da768778)
![image](https://github.com/lerc07/sendfiles/assets/151892038/c7a65056-caca-41d4-adce-c4cc322dae23)
![image](https://github.com/lerc07/sendfiles/assets/151892038/40a7fa42-f6fa-4780-9023-59606cb01823)
![image](https://github.com/lerc07/sendfiles/assets/151892038/e71e9874-1f9a-42bb-863b-8781241b8c29)
![image](https://github.com/lerc07/sendfiles/assets/151892038/c665c39d-f7ec-4a3f-ac1f-51268b6acdf5)
![image](https://github.com/lerc07/sendfiles/assets/151892038/c5db934e-7bb2-4a89-b617-0625e296399f)
![image](https://github.com/lerc07/sendfiles/assets/151892038/d053ff6a-fd77-49f8-a787-c7d56c2a0376)
![image](https://github.com/lerc07/sendfiles/assets/151892038/988596f6-2171-41ba-b7f2-d0f82d9c2227)

![image](https://github.com/lerc07/sendfiles/assets/151892038/bee04f37-6520-4d5f-883e-532da403bb52)

![image](https://github.com/lerc07/sendfiles/assets/151892038/1bd7dd57-3604-49e0-87fb-4c66dee64676)

Imagens TFTP
------------------------

![image](https://github.com/lerc07/sendfiles/assets/151892038/108e825b-72a9-4ed4-975a-bc57c9f0b828)
![image](https://github.com/lerc07/sendfiles/assets/151892038/8cca02ad-5d78-4c2f-9ca9-e0e2298be5fd)
![image](https://github.com/lerc07/sendfiles/assets/151892038/a0a5699d-aa3a-4535-9883-73792b7b7064)

Imagens FTP
------------------------

![image](https://github.com/lerc07/sendfiles/assets/151892038/cdce926a-a17c-4d83-bd61-f530123d2f9a)
![image](https://github.com/lerc07/sendfiles/assets/151892038/0a843c98-54f5-4712-950d-cfb462ce0bef)
![image](https://github.com/lerc07/sendfiles/assets/151892038/f7390b4d-d1bc-4b16-b49e-9519c23d8c3a)
![image](https://github.com/lerc07/sendfiles/assets/151892038/22d4dc91-ec86-402d-b1be-38043e8cf0c2)
![image](https://github.com/lerc07/sendfiles/assets/151892038/a638e2d9-043b-48c2-b345-a49166972090)

-----------------------

Ferramenta desenvolvida para utilizar em conjunto com o cgnatgen:

https://github.com/lerc07/cgnatgen

Agradecimento especial ao ChatGPT que ajudou em 70% no desenvolvimento. :D
 
