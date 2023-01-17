$ vim /home/ansible/inventory

```
[web]
node1
node2
```

$ vim /home/ansible/web.yml

- hosts: web
  become: yes
  tasks:
    - name: install httpd
      yum: name=httpd state=latest
    - name: start and enable httpd
      service: name=httpd state=started enabled=yes
    - name: retrieve website from repo
      get_url: url=http://repo.example.com/website.tgz dest=/tmp/website.tgz
    - name: install website
      unarchive: remote_src=yes src=/tmp/website.tgz dest=/var/www/html/

$ ansible-playbook -i inventory web.yml

Увидели много html кода и поняли, что сайт поднялся
$ curl node1/home.html