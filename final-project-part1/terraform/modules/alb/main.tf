resource "aws_lb" "backend" {
  name               = "backend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.subnet_ids

  tags = {
    Name = "backend-alb"
  }
}

resource "aws_lb_target_group" "backend" {
  name     = "backend-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = var.health_check_path
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

  tags = {
    Name = "backend-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.backend.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

resource "aws_autoscaling_attachment" "backend" {
  autoscaling_group_name = var.asg_name
  lb_target_group_arn    = aws_lb_target_group.backend.arn
}