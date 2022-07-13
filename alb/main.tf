resource "aws_lb" "alb" {
  name               = var.name
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.sg
  subnets            = var.subnet

  enable_deletion_protection = true

  access_logs {
    bucket  = var.s3_bucket_arn
    prefix  = "Thrinadh"
    enabled = true
  }

  tags = var.tags
}

resource "aws_alb_target_group" "group" {
  name     = var.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  stickiness {
    type = "lb_cookie"
  }
  health_check {
    path = "/index.html"
    port = 80
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.group.arn
    type             = "forward"
  }
}

resource "aws_launch_template" "template" {
  name_prefix   = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
  tags = var.tags
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_alb_target_group.group.arn
}