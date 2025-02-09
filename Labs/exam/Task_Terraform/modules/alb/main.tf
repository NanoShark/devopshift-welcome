resource "aws_lb" "michael-alb" {
  name = "michael-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = var.public_subnets
  enable_deletion_protection = false

  tags = {
    Name ="michael-alb"
  }
}

resource "aws_lb_target_group" "michael-target-group" {
  name = var.target_group_name
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path = "/"
    interval = 30
    timeout = 5
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "port_http_listener" {
  load_balancer_arn = aws_lb.michael-alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.michael-target-group.arn
  }
}

