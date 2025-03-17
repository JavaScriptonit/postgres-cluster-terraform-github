

resource "serverspace_isolated_network" "my_net" {
  location       = "ds1"
  name           = "my_net"
  description    = "Example for Terraform"
  network_prefix = "192.168.0.0"
  mask           = 24
}

resource "serverspace_server" "servers" {
  count          = 3
  image          = "Ubuntu-22.04-X64"
  name           = "postgres-server-${count.index + 1}"
  location       = "ds1"
  cpu            = 1
  ram            = 1024
  boot_volume_size = 40 * 640

  nic {
    network      = ""
    network_type = "PublicShared"
    bandwidth    = 50
  }

  nic {
    network      = serverspace_isolated_network.my_net.id
    network_type = "Isolated"
    bandwidth    = 0
  }

  ssh_keys = [
    serverspace_ssh.terraform.id,
  ]

  connection {
    host         = self.public_ip_addresses[0]
    user         = "root"
    type         = "ssh"
    private_key  = file(var.pvt_key)
    timeout      = "2m"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/setup.sh"
  }
}

output "server_ips" {
  value = serverspace_server.servers[*].public_ip_addresses[0]
}