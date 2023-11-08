variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "db_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd83mk5snsff9c5kgari"
}
variable "subnet_id" {
  description = "Subnet for modules"
}

