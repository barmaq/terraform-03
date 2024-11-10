resource "yandex_compute_disk" "disks" {
  count = 3
  name = "disk-${count.index}"
  type = "network-hdd"
  size = 1
}


resource "yandex_compute_instance" "storage" {
  name        = var.storage_name
  hostname    = var.storage_name
  zone        = var.default_zone
  platform_id = var.default_vm.standart.platform_id
  resources {
    cores         = var.default_vm.standart.cpu
    memory        = var.default_vm.standart.ram
    core_fraction = var.default_vm.standart.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.default_vm.standart.preemptible
  }
  network_interface {
    security_group_ids = [
    yandex_vpc_security_group.example.id,
  ]
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.default_vm.standart.nat
  }

  metadata = {
    serial-port-enable = var.default_vm.standart.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }

#добавляем динамические диски
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks[*]
    content {
      device_name    = secondary_disk.value.name
      disk_id        = secondary_disk.value.id
    }
  }
}