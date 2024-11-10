# сохраняем ключ в локальные перменные
locals {
  ssh_key = file("~/.ssh/ycbarmaq.pub")
}

#для блока с ansible

locals {
  webservers = {
    for idx, instance in yandex_compute_instance.web : 
    instance.name => {
      ip   = instance.network_interface[0].ip_address
      fqdn = instance.fqdn
    }
  }

  databases = {
    for idx, instance in yandex_compute_instance.databases : 
    instance.name => {
      ip   = instance.network_interface[0].ip_address
      fqdn = instance.fqdn
    }
  }

  storage = {
    # тут вариант аналогичный предыдущим не сработает - ключи не должны быть строками и не могут бытьв ычисляемым значением. поэтому надо использовать интерполяцию
    "${yandex_compute_instance.storage.name}" = {
      ip   = yandex_compute_instance.storage.network_interface[0].ip_address
      fqdn = yandex_compute_instance.storage.fqdn
    }
  }
}