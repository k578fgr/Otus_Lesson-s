terraform {
  # Версия terraform
  required_version = "1.2.9"
}

provider "google" {
  # Версия провайдера
  version = "3.32.0"

  # ID проекта
  project = var.project

  region = var.region
}


resource "google_compute_instance" "app" {
  name         = var.name
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }


  connection {
    type    = "ssh"
    host    = self.network_interface[0].access_config[0].nat_ip
    agent   = false
    timeout = "1m"
    port    = 22
    user    = var.users[0]
    # путь до приватного ключа
    private_key = "{file(var.private_key_path)}"

  }



  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  metadata = {
    ssh-keys        = "var.user:${(var.public_key_path)}"
  }

  network_interface {
    network = "default"
    access_config {}

  }
}


resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]


}