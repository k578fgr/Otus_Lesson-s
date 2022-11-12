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

$ ansible linux -m ping
Ключ m (module) включает модуль на всех машинах и пингует их, чтобы увидеть в сети ли они
linux - host machine

$ ansible linux -a "cat /etc/os-release"
-a adds commands (ключ добавляет команду)

playbook - yaml

playbook -> plays -> Tasks

Ещё один пример

---
  - name: iluvnano
    hosts: linux
    tasks:
      - name: ensure nano is there
        yum:
           name: nano
           state: latest

Модуль начинается после yum
а задача с - name (2)
проверяет установлен ли nano
запуск
в строке state: latest может быть absent (отсутствует)

```
ansible-playbook iluvnano.yml

```

Чтобы убрать авторизацию по ssh ключам на ansible нужно зайти

```
ansible.cfg
```
там

прокрутить до

```
#host_key_checking = False
```

убрать хэш
```
vi hosts
```
тут можно отредактировать группу хостов

```
[routers]

ios-xe-mgmt-latest.cisco.com
ios-xe-mgmt.cisco.com

[routers:vars]

ansible_user=developer
ansible_password=C1sco12345
ansible_connection=network_cli
ansible_network_os=ios
ansible_port=8181
```

ansible routers -m ios_command -a "commands='show ip int brief'"