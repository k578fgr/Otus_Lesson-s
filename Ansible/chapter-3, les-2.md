#!/bin/sh

# Remove transaction_list, otherwise playbook will not check url again.
rm -f /home/ansible/transaction_list > /dev/null;

# Is httpd running?
nc -z -w 50ms apps.l33t.com 80 > /dev/null


# Switch states depending on if it is up or down
if [ $? -ne 0 ];
then
  echo -n "Starting apps.l33t.com...";
  ansible node1 -b -m service -a "name=httpd state=started" > /dev/null;
  echo "done."
else
  echo -n "Stopping apps.l33t.com...";
  ansible node1 -b -m service -a "name=httpd state=stopped" > /dev/null;
  echo "done."
fi

---
- hosts: localhost
  tasks:
    - name: download transaction_list
     block:
       - get_url:
            url: http://apps.l33t.com/transaction_list
            dest: /home/ansible/transaction_list
       - replace:
           path: /home/ansible/transcation_list
           regexp: #BLANKLINE
           replace: '\n'
       - debug: msg="File downloaded"
     rescue:
       - debug: msg="l33t.com appears to be down. Try again later."
     always:
       - debug: msg"Attempt Comleted."