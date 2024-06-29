output "project_name" {
  value = var.project_name

}

output "region" {
  value = var.region

}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block

}

output "vpc_id" {
  value = aws_vpc.main.id

}