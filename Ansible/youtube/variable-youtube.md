vi /etc/ansible/hosts

```

host=192.168.1.1  owner=Vasya

```

```
---
- name: My Super Puper Playbook
  hosts: all
  become: ye


vars:
   message1: Privet
   message2: World
   secret  : Password

tasks:

-name: Print Secret variable
 debug:
   var: secret

- debug:
    msg: "Sekretnoe slovo: {{ secret }}"

- debug:
    msg: "Vladelec Etogo Servera --> {{ owner }}<--"

- set_fact: full_message "{{ message1 }} {{ message2 }} from {{ owner }}" #<----Совместить из разных мест

- debug:
    var: full_message

- debug:
    var: ansible_distribution           <-----показывает дистрибутив всех серверов

- shell: uptime
  register: results        <---переменная

- debug:
  register: results.stdout    (stdout это переменная из list)
```
