resource "aws_launch_template" "michael_lt" {
  name_prefix = "michael-lt"
  image_id = "ami-0e1bed4f06a3b463d"
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.instance_sg.id]
  }
   user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
              )
}

resource "aws_autoscaling_group" "micahel-auto-scaling-group" {
  vpc_zone_identifier = var.public_subnets
  desired_capacity = var.min_size
  min_size = var.min_size
  max_size = var.max_size

  launch_template {
    id = aws_launch_template.michael_lt.id
    version = "$Latest"
  }
    health_check_type = "EC2"
    health_check_grace_period = 300

    tag {
      key="Name"
      value = "michael-asg-instance"
      propagate_at_launch = true
    }
    lifecycle {
    create_before_destroy = true
  }
}

