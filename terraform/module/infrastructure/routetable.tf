resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "this" {
  count = var.subnet_count
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this.id
}

