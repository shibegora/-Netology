resource "yandex_compute_instance" "web" {
  depends_on = [ yandex_compute_instance.database ]
  count = 2
  name = "web-${count.index +1}"
  hostname = "web-${count.index +1}"
  platform_id = var.vm_platform_id
  zone = var.default_zone

  resources {
    cores = var.vm_resources.web.cores
    memory = var.vm_resources.web.memory
    core_fraction = var.vm_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_image.image_id
      type = var.vm_resources.web.type
      size = var.vm_resources.web.size
    }
  }
  scheduling_policy {
    preemptible = var.scheduling
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = var.network_interface
  }
  metadata = {
    serial-port-enable = var.serial_port_state
    ssh-keys = var.ssh_file
  }
  }
  
  