terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  #token     = "y0_AgAAAAAFFO12AATuwQAAAADwJqvdXhmCcEuRTR24lGDSmYlBmbWL-bw"
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  #cloud_id                 = "b1g8t8ui708klmdt9pg9"
  #folder_id                = "b1g570ghf7nlrs8od6ot"
  #zone                     = "ru-central1-a"
}

#resource "yandex_vpc_network" "app-network" {
#  name = "reddit-app-network"
#}

#resource "yandex_vpc_subnet" "app-subnet" {
#  name           = "reddit-app-subnet"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.app-network.id
#  v4_cidr_blocks = ["192.168.10.0/24"]
#}

#resource "yandex_compute_instance" "app" {
#  count       = var.counter
#  name        = "reddit-app-${count.index}"
#  platform_id = "standard-v3"
#  depends_on  = [yandex_vpc_subnet.app-subnet]
#  resources {
#    cores  = 2
#    memory = 2
#  }
#  boot_disk {
#    initialize_params {
# Указать id образа созданного в предыдущем домашнем задании
#image_id = "fd8mvkbfkadtrodfl2uv"
#      image_id = var.image_id
#    }
#  }
#  network_interface {
# Указан id подсети default-ru-central1-a
#    subnet_id = yandex_vpc_subnet.app-subnet.id
#    nat       = true
#  }
#  metadata = {
#    ssh-keys = "ubuntu:${file(var.public_key_path)}"
#  }
/*  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
#}
*/
