
 # Packer


#Авторизоваться на ADC

```
gcloud auth application-default login
```
(Там копируем ссылку и авторизовываемся под ней)

Скачать Packer для нужной версии

https://developer.hashicorp.com/packer/downloads

Создаём директорию и в ней файл **file.json**
В моём случае - это **ubuntu16.json**
В ней описано имя, сеть, образ и т.д.

В нём **builders** отвечает за систему, а
**provisioners** позволяет установить нужное ПО

Чтобы проверить сборку на ошибки запускаем команду
```
packer validate ./ubuntu16.json
```

Запустить сборку

```
packer build ubuntu16.json
```

Внутри виртуальной машины заводим

```
git clone -b monolith https://github.com/express42/reddit.git
```
```
cd reddit && bundle install
```
```
puma -d
```
```
ps aux | grep puma
```

А дальше открываем прослушиваеый порт

в нашем случае порт 9292

```
gcloud compute firewall-rules create allow-winrm --allow tcp:9292
```


мы научились собирать Packer

# Packer
Авторизоваться на ADC
gcloud auth application-default login
(Там копируем ссылку и авторизовываемся под ней)

Создаём директорию и в ней файл file.json
В моём случае - это ubuntu16.json
В ней описано имя, сеть, образ и т.д.

В нём **builders** отвечает за систему, а
**provisioners** позволяет установить нужное ПО
Чтобы проверить сборку на ошибки запускаем команду
packer validate ./ubuntu16.json

Запустить сборку
packer build ubuntu16.json

Внутри виртуальной машины заводим

```
git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install

puma -d

ps aux | grep puma
```

А дальше открываем прослушиваеый порт

Только почему-то в яндексе данный способ более-менее работал, а здесь уже нет
Но мы научились собирать Packer