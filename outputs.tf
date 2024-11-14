# Переделано
# output "count" {
#   value = [
#     for vm in yandex_compute_instance.web : {
#       name = vm.name
#       id   = vm.id
#       fqdn = vm.fqdn
#     }
#   ]
# }

# output "for_each" {
#   value = [
#     for vm in yandex_compute_instance.databases : {
#       name = vm.name
#       id   = vm.id
#       fqdn = vm.fqdn
#     }
#   ]
# }

# ДОПОЛНЕННОЕ!
#обьеденил при помощи concat
output "all_vms" {
  value = concat(
    [for vm in yandex_compute_instance.web : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }],
    [for vm in yandex_compute_instance.databases : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }]
  )
}


# тут дебаггинг для локальной переменной storage
output "instance_created" {
    value = try(
    # Если yandex_compute_instance.storage несколько инстансов (проверяем по индексу)
    { 
      for idx, instance in yandex_compute_instance.storage : 
      instance.name => {
        counter = idx
      }
    },
    "no index!"   
  )
}