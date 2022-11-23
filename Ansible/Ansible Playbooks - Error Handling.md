---
- hosts: localhost
  tasks:
    - name: download transaction_list
      get_url:
        url: http://apps.l33t.com/transaction_list
        dest: /home/ansible/transaction_list
    - debug: msg="File downloaded"

---
- hosts: localhost
  tasks:
    - name: download transaction_list
      block:
        - get_url:
            url: http://apps.l33t.com/transaction_list
            dest: /home/ansible/transaction_list
        - debug: msg="File downloaded"
      rescue:
        - debug: msg="l33t.com appears to be down.  Try again later."


---
- hosts: localhost
  tasks:
    - name: download transaction_list
      block:
        - get_url:
            url: http://apps.l33t.com/transaction_list
            dest: /home/ansible/transaction_list
        - replace:
            path: /home/ansible/transaction_list
            regexp: "#BLANKLINE"
            replace: '\n'
        - debug: msg="File downloaded"
      rescue:
        - debug: msg="l33t.com appears to be down.  Try again later."
      always:
        - debug: msg="Attempt completed."