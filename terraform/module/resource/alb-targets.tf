locals {
    targets = ["frontend", "backend"]
    }

resource "aws_lb_target_group_attachment" "this" {
    for_each = toset(local.targets)
  target_group_arn = aws_lb_target_group.this[each.key].arn
  target_id        = aws_instance.ec2[each.key].id
  port             = 80
}

resource "aws_lb_target_group" "this" {
    for_each = toset(local.targets)
  name        = "alb-tg-${each.key}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc.id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = var.alb_arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this["frontend"].arn
  }
}

resource "aws_lb_listener_rule" "backend" {
  listener_arn = aws_lb_listener.this.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this["backend"].arn
  }

  condition {
    path_pattern {
      values = ["/api/user"]
    }
  }
}