output "private-ip" {
  value = {for key, instance in aws_instance.ec2 : key => instance.private_ip }
}

output "public-ip" {
  value = aws_instance.loadbalancer.public_ip 
}
