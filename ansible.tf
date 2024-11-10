resource "local_file" "ansible_inventory" {
  filename = "./inventory"
  content  = templatefile("./inventory.tftpl", {
  #или через pathmodule
  #content  = templatefile("${path.module}/inventory.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}

#пересмотрел практику лекции внимательнее - удобнее было бы через :
# resource "local_file" "hosts_templatefile" {
#   content = templatefile("${path.module}/hosts.tftpl",

#   { webservers = yandex_compute_instance.example })

#   filename = "${abspath(path.module)}/hosts.ini"
# }
# и тогда шаблон :

# [webservers]

# %{~ for i in webservers ~}

# ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]} fqdn=${i["fqdn"]} 
# %{~ endfor ~}