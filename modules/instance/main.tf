data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

resource "yandex_compute_instance" "vm-manager" {
  count    = var.managers
  name     = "ci-sockshop-docker-swarm-manager-${count.index}"
  hostname = "manager-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys              = "soul:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNNPyG5NqjR0Q5w4qMiYnX0vxlyHf+edlRe3dZ8wEYG soul@Soul-PC"
    user-data             = "${file("user1.txt")}"
    install-unified-agent = "0"
    serial-port-enable    = "0"
  }

}
resource "yandex_compute_instance" "vm-worker" {
  count    = var.workers
  name     = "ci-sockshop-docker-swarm-worker-${count.index}"
  hostname = "worker-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys              = "soul:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNNPyG5NqjR0Q5w4qMiYnX0vxlyHf+edlRe3dZ8wEYG soul@Soul-PC"
    user-data             = "${file("user1.txt")}"
    install-unified-agent = "0"
    serial-port-enable    = "0"
  }

}
