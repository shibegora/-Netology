###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web_family_os" {
  type = string
  default = "ubuntu-2204-lts-oslogin"
  description = "Image name for VM OS"
}

variable "vm_platform_id" {
  type = string
  default     = "standard-v2"
  description = "Platform type of VM"
}

variable "scheduling" {
  type = bool
  default = true
  description = "default sheduling policy"
}

variable "network_interface"{
  type = bool
  default = true
}

variable "vm_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    type          = string
    size          = number
  }))
  default = {
    "web" = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      type          = "network-hdd"
      size          = 10
    }
  }
}

/*
old version
 variable "metadata" {
   type        = object({ serial-port-enable = number, ssh-keys = string })
   default     = { serial-port-enable = 1, ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILXl4CY64RiQq2kQq/29zWHe9mGf2s2HlG+Mm9ZWwyZd shibe@minik" }
   description = "Common ssh params"
 }
*/

variable "ssh_file" {
  type = string
  default = "C:\\Users\\shibe\\.ssh\\id_ed25519.pub"
  description = "public SSH key from local file"
}

variable "serial_port_state" {
  type = number
  default = 1
  description = "ssh params"
}

variable "each_vm" {
  type = map(object({
    platform_id=string
    vm_name=string
    cpu=number
    ram=number
    core_fraction=number
    type=string
    disk_volume=number
    network_interface=bool
    scheduling_policy=bool
    }))
  default = {
    "main" = {
      platform_id="standard-v2"
      vm_name="main"
      cpu=2
      ram=1
      core_fraction=5
      type="network-hdd"
      disk_volume=10
      network_interface=true
      scheduling_policy=true
    }
    "replica" = {
      platform_id="standard-v3"
      vm_name="replica"
      cpu=4
      ram=2
      core_fraction=20
      type="network-hdd"
      disk_volume=20
      network_interface=true
      scheduling_policy=true      
    }
  }
}

variable "disk_size" {
  type        = number
  default     = 1
  description = "HDD size (GB)"
}

variable "disk_type" {
  type        = string
  default     = "network-hdd"
  description = "HDD type"
}

variable "storage_vm_name" {
  type        = string
  default     = "storage"
  description = "Name of Storage VM"
}

variable "disk_count" {
  type    = number
  default = 3
  description = "Number of HDD disks to create"
}
