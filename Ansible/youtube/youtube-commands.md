Скопировать файл
ansible all -m copy -a "src=privet.txt dest=/home/"

Удалить файл на всех серверах
ansible all -m file -a "path=/home/privet.txt state=absent" -b

Скачать на все сервера dest= куда скачать
ansible all -m get_url -a "url=https://collectors.sumologic.com/rest/download/linux/64 dest=/home/" -b

ansible all -m shell -a "ls /home"

Установить installed=latest слова синонимы, а чтобы удалить нужно добавить removed
ansible all -m yum -a "name=stress state=installed" -b

Читать информацию с сайта
ansible all -m uri -a "url=http://www.adv-it.net"

ansible all -m uri -a "url=http://www.adv-it.net return_content=yes"

Установить apache сервера
ansible all -m yum -a "name=httpd state=latest" -b

Чтобы запускался с service
ansible all -m service -a "name=httpd state=started enabled=yes" -b"

Посмотреть пожробную информацию до 5 v
ansible server -m shell -a "ls /var/" -v 

Показать все модули, которые есть в anible
ansible-doc -l

Выполнить команду с паролем
ansible -m ping ubuntu -k

Увидеть данные серверов
ansible all -m setup