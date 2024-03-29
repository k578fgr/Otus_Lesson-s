## Авторизируемся внутри виртуальной машины с помощью
```
gcloud auth login
```

## Помните, как в предыдущем задании мы настраивали SSH
доступ к создаваемой VM, создавая пользовательские ключи?
Мы также говорили, что по умолчанию в новом проекте
создается правило файервола, открывающее SSH доступ ко всем
инстансам, запущенным в сети default (которая тоже создается по
умолчанию в новом проекте).
**Давайте найдем это правило:**
```
gcloud compute firewall-rules list
```

## Определим ресурс файервола Определим ресурс файервола
Посмотрев информацию об интересующем нас правиле
файервола, создайте ресурс в вашем конфиг файле main.tf
(после правила файервола для puma) с такой же конфигурацией,
что у уже имеющегося правила:
```
resource "google_compute_firewall" "firewall_ssh" {
name = "default-allow-ssh"
network = "default"
allow {
protocol = "tcp"
ports = ["22"]
}
source_ranges = ["0.0.0.0/0"]
}
```
# Возникла ошибка. Почему?

Терраформ не знает о новом правиле фаервола, его нужно в этом уведомить.
```
terraform import google_compute_firewall.firewall_ssh default-allow-ssh
```
Можете добавить свое
описание правила файервола в конфигурацию ресурса <firewall_ssh>.
После чего выполните *terraform apply*.

Ресурс IP адресаРесурс IP адреса
Зададим IP для инстанса с приложением в виде внешнего
ресурса. Для этого определим ресурс google_compute_address в
конфигурационном файле main.tf
```
resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
```
Ссылаемся на атрибуты другого ресурсаСсылаемся на атрибуты другого ресурса
Для того чтобы использовать созданный IP адрес в нашем
ресурсе VM нам необходимо сослаться на атрибуты ресурса,
который этот IP создает, внутри конфигурации ресурса VM. В
конфигурации ресурса VM определите, IP адрес для создаваемого
инстанса.

```
network_interface {
 network = "default"
 access_config {
   nat_ip = google_compute_address.app_ip.address
 }
}
```

**Столкнулся с ошибкой**
Если я пренебрегаю настройкой своего проекта, региона или зоны, я получаю бесполезное сообщение об ошибке:

error: Plan apply failed: project: required field is not set

**Поэтому я добавил в main**

```
provider "google" {
  # Версия провайдера
  version = "4.32.0"

  
  project = var.project

  region = var.region
}
```

# storage-bucket
Ошибки


**Error:** googleapi: Error 409: The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again., conflict

Изменил имя инстанса на другое



```
Error: Null condition
│ 
│   on .terraform/modules/awesome_bucket/main.tf line 2, in resource "google_storage_bucket" "default":
│    2:   count = var.enabled ? 1 : 0
│     ├────────────────
│     │ var.enabled is null
│ 
│ The condition value is null. Conditions must either be true or false.
```

Здесь изменил ошибку
sudo vim .terraform/modules/awesome_bucket/main.tf
изменил на
count = "1"

Здесь поменял имя бакета
sudo vim .terraform/modules/awesome_bucket/outputs.tf
value       = join("", google_storage_bucket.GnatkoBacket.*.self_link) заменил default на свой

задания со звёздочкой оставил на потом