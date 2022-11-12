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

ansible ALL=(ALL) NOPASSWD: ALL

create /home/ansible/inventory

workstation

**Так же можно добавить ip адресс нашей машины (пример)**
Изменим инвентори файл следующим образом:
ansible/inventory:
[app] #
⬅ Это название группы
workstation ansible_host=35.195.74.54 #
⬅ Cписок хостов в данной группе
[db]
control ansible_host=35.195.162.174

vim /home/ansible/git-setup.yml

 --- # install git on target host
    - hosts: workstation
      become: yes
      tasks:
      - name: install git
        yum:
          name: git
          state: latest

Run the playbook:

ansible-playbook -i /home/ansible/inventory /home/ansible/git-setup.yml
Verify that the playbook ran successfully:

Операция завершена
Выполнив эту лабораторную работу, мы теперь лучше понимаем, как развернуть Ansible, создать соединение между
два узла, создать простую инвентаризацию и написать Ansible playbook. Поздравляю с завершением этого
лаборатория!

ansible linux -m ping
Ключ m (module) включает модуль на всех машинах и пингует их, чтобы увидеть в сети ли они
linux - host machine

ansible linux -a "cat /etc/os-release"
-a adds commands