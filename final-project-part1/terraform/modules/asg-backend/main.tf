resource "aws_launch_template" "backend" {
  name_prefix   = "backend-lt-"
  image_id      = var.ami_id
  instance_type = "t3.small"
  key_name      = "linux-key"

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.backend_sg_id]
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    ecr_repo_url  = var.ecr_repo_url
    aws_region    = var.aws_region
    db_secret_arn = var.db_secret_arn
    db_host       = var.db_host
    db_name       = var.db_name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-instance"
    }
  }
}

resource "aws_autoscaling_group" "backend" {
  name                = "backend-asg"
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = [var.subnet_id]

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "backend-instance"
    propagate_at_launch = true
  }
}