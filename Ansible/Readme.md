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
vi /etc/ansible/hosts
```
тут можно отредактировать группу хостов


# Как можно сделать inventory file

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

Так же можно указать серверы all и серверы grouped и ungrouped

Так же можем соединять к примеру

```
[prod_DB]
10.0.0.1

[prod_WEB]
10.0.0.2

[prod_APP]
10.0.0.3

[prod_ALL:children]
prod_DB
prod_WEB
prod_APP
```

Можно выписать пароли и ssh ключи

```
[staging_servers]
linux ansible_host=172.31.8.69 

[staging_servers:vars]
ansible_user=ec2-user
ansible_ssh_private_key_files=/home/ec2-user/.sh/california-keyl.pem


Показывает сервера, группы, переменные к ним относятся

```
ansible-inventory --list
```




Handlers - это специальные задачи. Они вызываются из других задач ключевым словом notify.

Эти задачи срабатывают после выполнения всех задач в сценарии (play). При этом, если несколько задач вызвали одну и ту же задачу через notify, она выполниться только один раз.

Handlers описываются в своем подразделе playbook - handlers, так же, как и задачи. Для них используется такой же синтаксис, как и для задач.

```
---
- name: Verify apache installation
  hosts: webservers
  vars:
    http_port: 80
    max_clients: 200
  remote_user: root
  tasks:
    - name: Ensure apache is at the latest version
      ansible.builtin.yum:
        name: httpd
        state: latest

    - name: Write the apache config file
      ansible.builtin.template:
        src: /srv/httpd.j2
        dest: /etc/httpd.conf
      notify:
      - Restart apache

    - name: Ensure apache is running
      ansible.builtin.service:
        name: httpd
        state: started

  handlers:                     
    - name: Restart apache
      ansible.builtin.service:
        name: httpd
        state: restarted
        
```

