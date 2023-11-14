variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8hf5ibuevh12o7gs11"
}
variable "subnet_id" {
  description = "Subnet for modules"
}

