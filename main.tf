resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_web_image}"
}
resource "yandex_compute_instance" "platform" {
  name        = local.name_web
  platform_id = "${var.vm_web_platform_id}"

  resources {
    cores         = "${var.vms_resources_web["cores"]}"
    memory        = "${var.vms_resources_web["memory"]}"
    core_fraction = "${var.vms_resources_web["core_fraction"]}"
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = "${var.vm_web_preemptible}"
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = "${var.vm_web_nat}"
  }

  metadata = {
    serial-port-enable = "${var.metadata["serial-port-enable"]}"
    ssh-keys           = "${var.metadata["ssh-keys"]}"
  }

}
############################################################################
resource "yandex_compute_instance" "platform_db" {
  name        = local.name_db
  platform_id = "${var.vm_db_platform_id}"

  resources {
    cores         = "${var.vms_resources_db["cores"]}"
    memory        = "${var.vms_resources_db["memory"]}"
    core_fraction = "${var.vms_resources_db["core_fraction"]}"
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = "${var.vm_db_preemptible}"
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = "${var.vm_db_nat}"
  }

  metadata = {
    serial-port-enable = "${var.metadata["serial-port-enable"]}"
    ssh-keys           = "${var.metadata["ssh-keys"]}"
  }

}