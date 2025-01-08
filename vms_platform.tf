variable "vm_web_zone" {
  type = string
  default = "ru-central1-a"
  description = "Image name for VM OS"
}

variable "vm_web_name" {
type = string
default = "netology-develop-platform-web"
description = "Name and host name VM"  
}

variable "vpc_name" {
  type        = string
  default     = "develop_a"
  description = "VPC network & subnet name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
