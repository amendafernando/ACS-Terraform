resource "aws_security_group" "webservers_sg" {
  name_prefix = "${var.env}-webservers-sg"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-webservers-sg"
  }
}

resource "aws_launch_template" "webservers" {
  name_prefix   = "${var.env}-webservers-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [aws_security_group.webservers_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-webserver"
    }
  }
}

resource "aws_autoscaling_group" "webservers_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id      = aws_launch_template.webservers.id
    version = "$Latest"
  } 
#   tags = [{
#       key                 = "Name"
#       value               = "${var.env}-webserver"
#       propagate_at_launch = true
#     }]
}
