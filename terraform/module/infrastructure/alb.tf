# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/tutorial-application-load-balancer-cli.html
resource "aws_lb" "this" {
  name               = "alb-main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadbalancer.id]
  subnets            = [for subnet in aws_subnet.this : subnet.id]

  tags = {
    "Project" = var.project_name
  }
}

