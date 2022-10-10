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



variable "users" {
  type    = list(any)
  default = [ "appuser", "appuser1", "appuser2"]
}

variable "ssh_keys" {
  type        = list(any)
  description = "ssh_keys for users"
}

variable "name" {
  description = "name forinstance"
}