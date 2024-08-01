data "aws_ami" "ubuntu" {
  # Retrieve latest image on ubuntu 24.04 in the current operating region
  most_recent = true
  owners      = ["099720109477"] #canonical id
  filter {
    name   = "name"
    values = ["ubuntu/images/*24.04*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


resource "aws_instance" "ec2" {
  for_each      = var.instance

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.ssh_key

  # This value is set to true for testing purposes, but will be false once the setup with the loadbalancer works
  associate_public_ip_address = false
  
  subnet_id     = var.subnet[each.value.subnet_name].id
  vpc_security_group_ids = [aws_security_group.allow_all[each.key].id]

  tags = {
    Name      = each.key
    "project" = var.project_name
  }

}

resource "aws_instance" "loadbalancer" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.ssh_key

  associate_public_ip_address = true
  
  subnet_id     = var.loadbalancer-subnet.id
  vpc_security_group_ids = [aws_security_group.loadbalancer.id]

  tags = {
    Name      = "Loadbalancer"
    "project" = var.project_name
  }

}
