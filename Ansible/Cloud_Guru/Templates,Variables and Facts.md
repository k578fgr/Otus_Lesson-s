# Create a Template sudoers File

[ansible@control1]$ vim /home/ansible/hardened.j2
Now that we're in Vim, we'll put these contents in the file:


%sysops {{ ansible_default_ipv4.address }} = (ALL) ALL
Host_Alias WEBSERVERS = {{ groups['web']|join(' ') }}
Host_Alias DBSERVERS = {{ groups['database']|join(' ') }}
%httpd WEBSERVERS = /bin/su - webuser
%dba DBSERVERS = /bin/su - dbuser

# Create a Playbook
[ansible@control1]$ vim /home/ansible/security.yml
The security.yml file should look like this:

---
- hosts: all
  become: yes
  tasks:
  - name: deploy sudo template
    template:
      src: /home/ansible/hardened.j2
      dest: /etc/sudoers.d/hardened
      validate: /sbin/visudo -cf %s

Run the Playbook
[ansible@control1]$ ansible-playbook /home/ansible/security.yml
The output will show that everything deployed fine, but we can check locally to make sure. Let's become root (with sudo su -) and then read our file:

[ansible@control1]$ sudo cat /etc/sudoers.d/hardened
The custom IP and host aliases are in there.