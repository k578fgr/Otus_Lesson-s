$ ansible-galaxy init db
- db was created successfully
$ tree db
db
├── README.md
├── defaults # <-- Директория для переменных по умолчанию
│ └── main.yml
├── handlers
│ └── main.yml
├── meta # <-- Информация о роли, создателе и зависимостях
│ └── main.yml
├── tasks # <-- Директория для тасков
│ └── main.yml
├── tests
│ ├── inventory
│ └── test.yml
└── vars # <-- Директория для переменных, которые не должны
└── main.yml # переопределяться пользователем
6 directories, 8 files

# tasks file for db
- name: Change mongo config file
template:
src: templates/mongod.conf.j2
dest: /etc/mongod.conf
mode: 0644
notify: restart mongod