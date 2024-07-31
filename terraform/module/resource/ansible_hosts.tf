resource "local_file" "name" {
  content = templatefile("${path.module}/hosts.tftpl", local.vars)
  filename = "${path.root}/../ansible/hosts.yml"
}

locals {
  vars = {
    ssh_key = var.ssh_key
    instance_ips = {for key, instance in aws_instance.ec2 : key => instance.public_ip }

  }
}