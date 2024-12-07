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
  
  ingress {
    description = "Allow Ping (ICMP)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
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
  ami           = "ami-0453ec754f44f9a4a" 
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_ids[3]
  key_name      = aws_key_pair.assignment_key.key_name

  vpc_security_group_ids = [aws_security_group.webserver4_sg.id] # Use SG by ID

  tags = {
    Name = "webserver4"
    WebServer = "true"
  }
}






# Security Group for Webserver 3
resource "aws_security_group" "webserver3_sg" {
  name_prefix = "webserver3-sg"
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
    Name = "webserver3-sg"
  }
}

# Key Pair for Webserver 3
resource "aws_key_pair" "webserver3_key" {
  key_name   = "webserver3-key"
  public_key = file("${path.module}/../../keys/my-key.pub")
}

# Webserver 3 Instance
resource "aws_instance" "webserver3" {
  ami           = "ami-0453ec754f44f9a4a" # Replace with Amazon Linux 2023 AMI ID
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_ids[2] # Subnet 3
  key_name      = aws_key_pair.webserver3_key.key_name

  vpc_security_group_ids = [aws_security_group.webserver3_sg.id] # Use SG by ID

  tags = {
    Name      = "webserver3"
    WebServer = "true"
  }
}
