#а вот тут было неприятно. попросили создать list а с ним for each loop не сработает. переводим в карту.  для себя for vm in var.each_vm: Это конструкция цикла for, которая перебирает каждый элемент в списке var.each_vm. Переменная vm будет представлять текущий объект на каждой итерации.

resource "yandex_compute_instance" "databases" {
  depends_on = [yandex_compute_instance.web]
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  hostname    = each.value.vm_name
  zone        = var.default_zone
  platform_id = var.default_vm.standart.platform_id
  
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.default_vm.standart.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size        = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.default_vm.standart.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.default_vm.standart.nat
  }

  metadata = {
    serial-port-enable = var.default_vm.standart.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }

}