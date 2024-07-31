resource "local_file" "name" {
  content = templatefile("${path.module}/hosts.tftpl", local.vars)
  filename = "${path.root}/../ansible/hosts.yml"
}

locals {
  vars = {
    loadbalancer = aws_instance.loadbalancer.public_ip 
    ssh_key = var.ssh_key
    instance_ips = {for key, instance in aws_instance.ec2 : key => instance.private_ip }

  }
}