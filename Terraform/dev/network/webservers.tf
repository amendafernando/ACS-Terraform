# Security Group for Webserver 4
resource "aws_security_group" "webserver4_sg" {
  name_prefix = "webserver4-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver4-sg"
  }
}

# Key Pair for Webserver 4
resource "aws_key_pair" "assignment_key" {
  key_name   = "assignment-key"
  public_key = file("${path.module}/../../keys/my-key.pub")
}

# Webserver 4 Instance
resource "aws_instance" "webserver4" {
  ami           = "ami-0453ec754f44f9a4a" # Replace with Amazon Linux 2023 AMI ID
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[3]
  key_name      = aws_key_pair.assignment_key.key_name

  vpc_security_group_ids = [aws_security_group.webserver4_sg.id] # Use SG by ID

  tags = {
    Name = "webserver4"
    WebServer = "true"
  }
}
