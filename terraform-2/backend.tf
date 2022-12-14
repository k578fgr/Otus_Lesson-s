### объявляючто бэкенд терраформа в гуглоклаудсторадже
# Дисклеймер! Создать бакет надо заранее из отдельной директории. К примеру из корневой ./terraform , где присутствует storage-bucket.tf.
# До выполнения инита. плана и эплая нет необходимости делать импорт состояния клауда. При дестое бакет остается и не уничтожается.
terraform {
  # мы убрали секцию terraform из майна, но указать версию это хорошо и я решил сохраниить required_version
  required_version = "~>0.12.8"
  backend "gcs" {
    # в бакете будет жить бэк
    bucket  = "storage-bucket-sgremyachikh-for-docker"
    # для отдельного окружения - отдельный префикс с блэкджеком и профурсетками
    prefix  = "terraform/repo/microservices/for_docker"
}
}

#Спасибо Светозару за ответ, не был уверен в данной информации
#https://raw.githubusercontent.com/Otus-DevOps-2019-08/sgremyachikh_microservices/master/terraform/