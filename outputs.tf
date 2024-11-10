output "count" {
  value = [
    for vm in yandex_compute_instance.web : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }
  ]
}

output "for_each" {
  value = [
    for vm in yandex_compute_instance.databases : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }
  ]
}