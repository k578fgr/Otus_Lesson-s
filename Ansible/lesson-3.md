 

file media
Paste in the following:

media_content: /tmp/var/media/content/
media_index: /tmp/opt/media/mediaIndex

Move into the group_vars directory:

cd group_vars/
Create a webservers file:

touch webservers
Edit the file:

vim webservers
Paste in the following:

httpd_webroot: /var/www/
httpd_config: /etc/httpd/

Move into the home directory:

cd ~
Create a host_vars directory:

mkdir host_vars
Move into the host_vars directory:

cd host_vars/
Create a web1 file:

touch web1
Edit the file:

vim web1
Paste in the following:

script_files: /tmp/usr/local/scripts

run backup.sh
```
#!/bin/sh

# Need to take a tag varialbe
# mediavars to test media
# webservervars to test webservers
# hostvar to test host var
# use playbook tags maybe?

case "$1" in
  mediavars)
    ansible-playbook -i /home/ansible/inventory /home/ansible/
scripts/backup.yml --tags "mediavars"
    exit $?
    ;;
  webservervars)
    ansible-playbook -i /home/ansible/inventory /home/ansible/
scripts/backup.yml --tags "webservervars"
    exit $?
    ;;
  hostvar)
    ansible-playbook -i /home/ansible/inventory /home/ansible/
scripts/backup.yml --tags "hostvar"
    exit $?
    ;;
  *)
    ansible-playbook -i /home/ansible/inventory /home/ansible/
scripts/backup.yml
    exit $?
esac
```


**backup.yml**

```
---
- hosts: all
  become: yes
  tasks:
    - name: create backup directories
      file:
        path: /mnt/backup_vol/{{ ansible_hostname }}
        state: directory
      tags:
        - hostvar
        - webservervars
        - mediavars
- hosts: web1
  become: yes
  tasks:
    - name: backup scripts
      archive:
        dest: /mnt/backup_vol/{{ ansible_hostname }}/scripts.tgz
        path: "{{ script_files }}"
      tags: hostvar

- hosts: webservers
  become: yes
  tasks:
    - name: backup httpd configs
      archive:
        dest: /mnt/backup_vol/{{ ansible_hostname }}/
httpd_configs.tgz
        path: "{{ httpd_config }}"
      tags: webservervars
    - name: backup webroot
      archive:
        dest: /mnt/backup_vol/{{ ansible_hostname }}/
httpd_webroot.tgz
        path: "{{ httpd_webroot }}"
      tags: webservervars

- hosts: media
  become: yes
  tasks:
    - name: backup media content
      archive:
        dest: /mnt/backup_vol/{{ ansible_hostname }}/
media_content.tgz
        path: "{{ media_content }}"
      tags: mediavars
    - name: backup media index
      archive:
        dest: /mnt/backup_vol/{{ ansible_hostname }}/media_index.
tgz
        path: "{{ media_index }}"
      tags: mediavars
```

 











