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

#не принято при проверке - предусмотреть вариант при нескольких инстансах
  # storage = {
  #   # тут вариант аналогичный предыдущим не сработает - ключи не должны быть строками и не могут быть вычисляемым значением. поэтому надо использовать интерполяцию
  #   "${yandex_compute_instance.storage.name}" = {
  #     ip   = yandex_compute_instance.storage.network_interface[0].ip_address
  #     fqdn = yandex_compute_instance.storage.fqdn
  #   }
  # }

# ДОПОЛНЕННОЕ!
#делаем через проверку try
  storage = try(
    # Если yandex_compute_instance.storage несколько инстансов (проверяем по индексу)
    { 
      for idx, instance in yandex_compute_instance.storage : 
      instance.name => {
        ip   = instance.network_interface[0].ip_address
        fqdn = instance.fqdn
        error_marker = "have index"
      }
    },
    # при ошибке - напрямую
    {
      "${yandex_compute_instance.storage.name}" = {
        ip   = yandex_compute_instance.storage.network_interface[0].ip_address
        fqdn = yandex_compute_instance.storage.fqdn
        error_marker = "no index!"
      }
    }
  )
}
