sudo apt install ansible - Установил Ansible

# Centos 7

Имеем две машины workstation и control

sudo yum install epel-release

sudo adduser ansible

sudo passwd ansible

П. с. Тоже самое на другой машине

sudo su - ansible

ssh-keygen

ssh-copy-id workstation

sudo visudo