утилита ansiblr-galaxy 
Создаст пустой шаблон для загатовки форм

```
$ roles ansible-galaxy init autoupdate
```


Перезапустить сервис
```
---
- name: Configure hosts & deploy application
hosts: all
vars:
mongo_bind_ip: 0.0.0.0
tasks:
- name: Change mongo config file
become: true
template:
src: templates/mongod.conf.j2
dest: /etc/mongod.conf
mode: 0644
tags: db-tag
notify: restart mongod
handlers: # <-- Добавим блок handlers и задачу
- name: restart mongod
become: true
service: name=mongod state=restarted
```

Тест
ansible-playbook reddit_app.yml --check --limit db

Добавить автостарт сервис

```
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple
EnvironmentFile=/home/appuser/db_config
User=appuser
WorkingDirectory=/home/appuser/reddit
ExecStart=/bin/bash -lc 'puma'
Restart=always

[Install]
WantedBy=multi-user.target
```