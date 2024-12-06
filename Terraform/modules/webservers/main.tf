resource "aws_key_pair" "webservers_key" {
  key_name   = var.key_name  # Use "my-key" as the key name
  public_key = file("${path.module}/../../keys/my-key.pub")
}

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
  key_name      = aws_key_pair.webservers_key.key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    echo "<h1>Welcome to ACS730 Assignment 2 WebServer!</h1> Private IP is $(hostname -I | awk '{print $1}') <br><br>Built by Terraform!" > /var/www/html/index.html
    systemctl start httpd
    systemctl enable httpd
  EOF
  )

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
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.webservers.id
    version = aws_launch_template.webservers.latest_version  # Correct usage
  }

  tag {
    key                 = "Name"
    value               = "${var.env}-webserver"
    propagate_at_launch = true
  }
}

resource "aws_instance" "webserver5" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[0] # Assign to Private Subnet 1
  key_name      = aws_key_pair.webservers_key.key_name
  vpc_security_group_ids = [aws_security_group.webservers_sg.id]

  tags = {
    Name = "${var.env}-webserver5"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    echo "<html><body><h1>Welcome to Web Server 5 (Private Subnet)</h1></body></html>" > /var/www/html/index.html
  EOF
}

resource "aws_instance" "vm6" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[1] # Assign to Private Subnet 2
  key_name      = aws_key_pair.webservers_key.key_name
  vpc_security_group_ids = [aws_security_group.webservers_sg.id]

  tags = {
    Name = "${var.env}-vm6"
  }
}

output "webserver5_id" {
  value = aws_instance.webserver5.id
}

output "vm6_id" {
  value = aws_instance.vm6.id
}
