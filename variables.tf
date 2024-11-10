###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
  default     = "y0_AgAAAAAHxUraAATuwQAAAAEWBwILAABq21DjNndL_pFkxN01awdJD01ccw"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default     = "b1g2678hn0b6tk45jj76"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = "b1gg0512n1fejb81t8f8"
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

# для машины с дисками
variable "storage_name" {
  type        = string
  default     = "storage"
  description = "storage VM name"
}


#дефолтная вирт машина для парметров по умолчанию и для создания по count
variable "default_vm" {
  type = map(object({
    image_family         = string
    vm_name              = string
    platform_id          = string
    cpu                  = number
    ram                  = number
    core_fraction        = number
    disk_volume          = number
    nat                  = bool
    preemptible          = bool
    serial-port-enable   = number
  }))
  default = {
    "standart" = {
      image_family         = "ubuntu-2004-lts"
      vm_name              = "web"
      platform_id          = "standard-v3"
      cpu                  = 2
      ram                  = 1
      core_fraction        = 20
      disk_volume          = 15
      nat                  = true
      preemptible          = true
      serial-port-enable    = 1
    }
  }
}

variable "each_vm" {
  type = list(object({
      vm_name=string,
      cpu=number,
      ram=number,
      disk_volume=number }))

      default = [
        {
        vm_name     = "main"
        cpu         = 2
        ram         = 1
        disk_volume = 15  
        },

        {
        vm_name     = "replica"
        cpu         = 2
        ram         = 2
        disk_volume = 20  
        }
      ]     
}


