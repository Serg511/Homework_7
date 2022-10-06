resource "yandex_compute_disk" "iscsi_disk" {
  name = "iscsi"
  zone = var.zone  
  size = 1
}

resource "yandex_compute_instance" "iscsi-" {
  depends_on = [yandex_vpc_subnet.subnet-1]
  name = "iscsi-${count.index}"
  count = 1

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  secondary_disk {
    disk_id = yandex_compute_disk.iscsi_disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}