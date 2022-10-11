# Работа с Terraform

Установка Terraform На G-cloud

Проверяем версию terraform
```
terraform -v
```
Моя версия 1.2.9

Скачать terraform для ОС можно по ссылке
https://www.terraform.io/downloads

Создаём файл main.tf и добавляем в него провайдеа


  # Версия terraform
  required_version = "1.2.9"

```
provider "google" {
  ## Версия провайдера
  version = "3.32.0"

  ## ID проекта
  project = "your project id"

  region = var.region
}
```
Версию терраформа можно найти на сайте

**Чтобы зайти нужен ВПН (Запрещён вход для РФ)**

https://registry.terraform.io/providers/hashicorp/google/4.31.0

Здесь можно увидеть последнюю версию и то как оно должно быть записано в "user provider", которую нужно записать к себе 

**Добавляем в .gitignore**

<br> *.tfstate </br>
<br> *.tfstate.backup </br>
<br> *.tfvars </br>
<br> *.terraform </br>

После провайдер добавляем ресурс для создания инстанса
в строке image правим на свой

```
resource "google_compute_instance" "app" {
  name = var.name
  machine_type = "g1-small"
  zone = var.zone
  boot_disk {
    initialize_params {
      image = var.name
    }
  }
  
  network_interface {
    network = "default"
    access_config {}
  }
}
```
Затем выполняем команду
```
terraform plan
```
Которая покажет, что terraform планирует сделать с известными ему ресурсами (tfstate файл)

После плана делаем апрув созданию инстанса
terraform apply

Результатом выполнения команды также будет создание файла
terraform.tfstate в директории terraform.
Terraform хранит в этом файле состояние управляемых им
ресурсов. Загляните в этот файл и найдите внешний IP адрес
созданного инстанса.

## Команда
```
terraform show | grep nat_ip
```

**Покажет айпи созданного инстанса**

# Создайте файл outputs.tf в директории terraform со
следующим содержимым.
```
output "app_external_ip" {
  value = google_compute_instance.app.network_interface[0].access_config[0].nat_ip
}
```
Используем команду 
```
terraform refresh
```
 чтобы выходная
переменная приняла значение.

после этого команда
```
terraform output
```
покажет айпишник

Внутрь ресурса, содержащего описание VM, вставьте секцию
провижинера типа **file**, который позволяет копировать содержимое
файла на удаленную машину.
```
provisioner "file" {
  source = "files/puma.service"
  destination = "/tmp/puma.service"
}
```

В нашем случае мы говорим, провижинеру скопировать
локальный файл, располагающийся по указанному относительному
пути **(files/puma.service)**, в указанное место на удаленном хосте.

Unit file для PumaUnit file для Puma
В определении провижинера мы указали путь до systemd unit
файла для Puma. 

Systemd использует unit файлы для запуска,
остановки сервиса или добавления его в автозапуск. С его
помощью мы можем запускать сервер приложения, используя
команду systemctl start puma.
Создадим директорию files внутри директории terraform и
создадим внутри нее файл puma.service

```
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple
User=appuser
WorkingDirectory=/home/appuser/reddit
ExecStart=/bin/bash -lc 'puma'
Restart=always

[Install]
WantedBy=multi-user.target
```

Добавим еще один провиженер для запуска скрипта деплоя
приложения на создаваемом инстансе. Сразу же после
определения провижинера file (провижинеры выполняются по
порядку их определения), вставьте секцию провижинера remote-
exec:

```
#!/bin/bash
set -e

APP_DIR=${1:-$HOME}

git clone -b monolith https://github.com/express42/reddit.git

 
cd $APP_DIR/reddit

bundle install


sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma

```
Добавлены публичные ключи для пользователей appuser2 и appuser3
resource "google_compute_project_metadata_item" "ssh-keys1" {
  key = "ssh-keys"
  value = "appuser1:${file(var.public_key_path)}"
}
resource "google_compute_project_metadata_item" "ssh-keys2" {
  key = "ssh-keys"
  value = "appuser2:${file(var.public_key_path)}"
}
resource "google_compute_project_metadata_item" "ssh-keys3" {
  key = "ssh-keys"
  value = "appuser3:${file(var.public_key_path)}"
}
```
# P.S.
Я допустил ошибку и не убрал свои ssh ключи перед созданием инстанса,
Теперь ругается на добавление новых пользователей)

Для записаных пользователей
Дополнительные ключи добавлены в один ресурс

