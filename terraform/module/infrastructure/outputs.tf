output "project_name" {
  value = var.project_name

}

output "region" {
  value = var.region

}

output "vpc" {
  value = {
    id         = aws_vpc.this.id
    cidr_block = aws_vpc.this.cidr_block
  }
}

output "subnet" {
  #For each created subnet, an output object gets created with the id and cidr_block.
  value = { for subnet in aws_subnet.private :
    "${subnet.tags.Name}" => {
      id         = subnet.id
      cidr_block = subnet.cidr_block
    }
  }
}

output "loadbalancer-subnet" {
  value = {
      id         = aws_subnet.public.id
      cidr_block = aws_subnet.public.cidr_block
    }
  }
