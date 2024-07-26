resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name      = "main"
    "Project" = var.project_name
  }

}