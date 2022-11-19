# Пример

 ---
- name: Configure hosts & deploy application # <-- Словесное описание сценария
(name)
hosts: all # <-- Для каких хостов будут выполняться описанные ниже таски
(hosts)
tasks: # <-- Блок тасков (заданий), которые будут выполняться для данных
хостов


# Сценарий для MongoDB

Используем модуль template, чтобы скопировать
параметризированный локальный конфиг файл MongoDB на
удаленный хост по указанному пути. Добавим task в файл
ansible/reddit_app.yml:

# Файл templates/mongod.conf.j2
Файл templates/mongod.conf.j2

# Where and how to store data.
storage:
dbPath: /var/lib/mongodb
journal:
enabled: true

# Where to write logging data.
systemLog:
destination: file
logAppend: true
path: /var/log/mongodb/mongod.log
# Network interfaces
net:
# default - один из фильтров Jinja2, он задает значение по умолчанию,
# если переменная слева не определена
port: {{ mongo_port | default('27017') }}
bindIp: {{ mongo_bind_ip }} # <-- Подстановка значения переменной

#Where and how to store data.

---
- name: Configure hosts & deploy application
hosts: all
vars:
mongo_bind_ip: 0.0.0.0 # <-- Переменная задается в блоке vars
tasks:
- name: Change mongo config file
become: true
template:
src: templates/mongod.conf.j2
dest: /etc/mongod.conf
mode: 0644
tags: db-tag



ansible-playbook --check

Покажет лист variable для всех хостов
ansible-inventory --list


ansible-inventory --graph

--limit - ограничиваем группу хостов, для которых
применить плейбук

ansible-playbook reddit_app.yml --check --limit db

