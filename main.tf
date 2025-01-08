#создаем облачную сеть develop
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop_a" {
  name           = var.vpc_name
  zone           = var.vm_web_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = var.vpc_name_b
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family_os
}
resource "yandex_compute_instance" "platform_web" {
  name        = local.vm_web_name
  hostname    = local.vm_web_name
  platform_id = var.vm_platform_id
  zone        = var.vm_web_zone
  resources {
    cores         = var.vm_resources.web.cores
    memory        = var.vm.resources.web.memory
    core_fraction = var.vm_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_resources.web.type
      size     = var.vm_resources.web.size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  hostname    = local.vm_db_name
  platform_id = var.vm_platform_id
  zone        = var.vm_db_zone
  resources {
    cores         = var.vm_resources.db.cores
    memory        = var.vm_resources.db.memory
    core_fraction = var.vm_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_resources.db.type
      size     = var.vm_resources.db.size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }
}