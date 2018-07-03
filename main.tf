variable "token" {}

provider "hcloud" {
  token = "${var.token}"
}

resource "hcloud_ssh_key" "x200t" {
  name = "gchevalley@x200t"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "hcloud_server" "master" {
  name = "master"
  image = "debian-9"
  server_type = "cx11"
  ssh_keys = ["${hcloud_ssh_key.x200t.id}"]
  datacenter = "fsn1-dc8"
  rescue = "linux64"

  connection {
    host = "${hcloud_server.master.ipv4_address}"
    timeout = "1m"
    agent = false
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "ignition.yml"
    destination = "/root/ignition.yml"
  }

  provisioner "remote-exec" {
    script = "install.sh"
  }

  provisioner "remote-exec" {
    connection {
      host = "${hcloud_server.master.ipv4_address}"
      timeout = "1m"
      agent = false
      private_key = "${file("~/.ssh/id_rsa")}"
      user = "core"
    }
    inline = "sudo hostnamectl set-hostname ${hcloud_server.master.name}"
  }
}


resource "hcloud_server" "node1" {
  name = "node1"
  image = "debian-9"
  server_type = "cx11"
  ssh_keys = ["${hcloud_ssh_key.x200t.id}"]
  datacenter = "fsn1-dc8"
  rescue = "linux64"

  connection {
    host = "${hcloud_server.node1.ipv4_address}"
    timeout = "1m"
    agent = false
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "ignition.yml"
    destination = "/root/ignition.yml"
  }

  provisioner "remote-exec" {
    script = "install.sh"
  }

  provisioner "remote-exec" {
    connection {
      host = "${hcloud_server.node1.ipv4_address}"
      timeout = "1m"
      agent = false
      private_key = "${file("~/.ssh/id_rsa")}"
      user = "core"
    }
    inline = "sudo hostnamectl set-hostname ${hcloud_server.node1.name}"
  }
}
