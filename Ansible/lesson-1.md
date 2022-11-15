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
---
- name: Configure hosts & deploy application
hosts: all
tasks:
- name: Change mongo config file
become: true # <-- Выполнить задание от root
template:
src: templates/mongod.conf.j2 # <-- Путь до локального файла-шаблона
dest: /etc/mongod.conf # <-- Путь на удаленном хосте
mode: 0644 # <-- Права на файл, которые нужно установить


# Файл templates/mongod.conf.j2

#Where and how to store data.
storage:
dbPath: /var/lib/mongodb
journal:
enabled: true
#Where to write logging data.
systemLog:
destination: file
logAppend: true
path: /var/log/mongodb/mongod.log
#Network interfaces
net:
#default - один из фильтров Jinja2, он задает значение по умолчанию,
#если переменная слева не определена
port: {{ mongo_port | default('27017') }}
bindIp: {{ mongo_bind_ip }} # <-- Подстановка значения переменной


ansible-playbook --check