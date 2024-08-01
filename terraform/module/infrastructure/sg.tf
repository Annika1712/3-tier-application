resource "aws_security_group" "loadbalancer" {
  name        = "Allow-all-loadbalance-traffic"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = "80"
    to_port     = "80"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}