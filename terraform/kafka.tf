resource "yandex_compute_instance" "kafka-" {
  depends_on = [yandex_vpc_subnet.subnet-1]
  count = 1
  name = "kafka-${count.index}"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}