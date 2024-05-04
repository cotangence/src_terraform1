
output "vm_web_external_ip_address" {
  value = yandex_compute_instance.platform.network_interface[0].nat_ip_address
  description = "vm external ip"
}

output "vm_web_instance_name" {
  value = yandex_compute_instance.platform.name
  description = "instance name"
}

output "vm_web_fqdn" {
  value = yandex_compute_instance.platform.fqdn
  description = "vm fqdn"
}

output "vm_db_external_ip_address" {
  value = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address
  description = "vm external ip"
}

output "vm_db_instance_name" {
  value = yandex_compute_instance.platform_db.name
  description = "instance name"
}

output "vm_db_fqdn" {
  value = yandex_compute_instance.platform_db.fqdn
  description = "vm fqdn"
}