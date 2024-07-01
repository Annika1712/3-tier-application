output "ip" {
  value = {for key, instance in aws_instance.ec2 : key => instance.public_ip }
}