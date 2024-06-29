output "project_name" {
  value = var.project_name

}

output "region" {
  value = var.region

}

output "vpc" {
  value = {
    id   = aws_vpc.main.id
    cidr = aws_vpc.main.cidr_block
  }
}

output "subnet" {
  #For each created subnet, an output object gets created with the id and cidr_block.
  value = [for subnet in aws_subnet.main :
    {
      id         = subnet.id
      cidr_block = subnet.cidr_block
    }
  ]
}