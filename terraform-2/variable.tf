variable "project" {
  description = "Project ID"
}
variable "region" {
  description = "region"
  # Значение по умолчанию
  default = "northamerica-northeast1"
}

variable "zone" {
  default = "northamerica-northeast1-c"
}

variable "private_key_path" {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}

variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable "disk_image" {
  description = "Disk image"
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default = "app-disk-image-1665691429"
}

variable "db_disk_image" {
  description = "Disk image for reddit db"
  default = "db-disk-image-1665692292"
}