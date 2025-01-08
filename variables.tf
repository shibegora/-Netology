###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
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
###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILXl4CY64RiQq2kQq/29zWHe9mGf2s2HlG+Mm9ZWwyZd shibe@minik"
#   description = "ssh-keygen -t ed25519"
# }

############################################################

variable "vpc_name_b" {
  type        = string
  default     = "develop_b"
  description = "VPC network & subnet name"
}

variable "vm_db_zone" {
  type = string
  default = "ru-central1-b"
  description = "Image name for VM OS"
}

variable "default_cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_name" {
type = string
default = "netology-develop-platform-db"
description = "Name and host name VM"  
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
    },
    "db" = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      type          = "network-hdd"
      size          = 10
    }
  }
}
variable "metadata" {
  type        = object({ serial-port-enable = number, ssh-keys = string })
  default     = { serial-port-enable = 1, ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILXl4CY64RiQq2kQq/29zWHe9mGf2s2HlG+Mm9ZWwyZd shibe@minik" }
  description = "Common ssh params"
}