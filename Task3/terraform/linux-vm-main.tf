# Virtual Machine Module - Main

# Create Elastic IP for the EC2 instance
resource "aws_eip" "linux-eip-ubuntu" {
  vpc  = true
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-eip"
    Environment = var.app_environment
  }
}

resource "aws_eip" "linux-eip-centos" {
  vpc  = true
  tags = {
    Name        = "${lower(var.app_name_centos)}-${var.app_environment_centos}-linux-eip"
    Environment = var.app_environment
  }
}

# Create EC2 Instances
resource "aws_instance" "ubuntu-server" {
  ami                         = data.aws_ami.ubuntu-linux-2004.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.aws-ubuntu-sg.id]
  associate_public_ip_address = true
  source_dest_check           = false
  key_name                    = aws_key_pair.key_pair_ubuntu.key_name
  user_data                   = file("aws-install.sh")
  
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-server"
    Environment = var.app_environment
  }
}
resource "aws_instance" "centos-server"{
  ami                         = data.aws_ami.centos-9.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.aws-centos-sg.id]
  associate_public_ip_address = false
  source_dest_check           = false
  key_name                    = aws_key_pair.key_pair_centos.key_name
  user_data                   = file("aws-centos-install.sh")

  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
  }

  tags = {
    Name        = "${lower(var.app_name_centos)}-${var.app_environment_centos}-linux-server"
    Environment = var.app_environment
  }
}

# Associate Elastic IP to Linux Server
resource "aws_eip_association" "ubuntu-eip-association" {
  instance_id   = aws_instance.ubuntu-server.id
  allocation_id = aws_eip.linux-eip-ubuntu.id
}

resource "aws_eip_association" "centos-eip-association" {
  instance_id   = aws_instance.centos-server.id
  allocation_id = aws_eip.linux-eip-centos.id
}


# Define the security group for the Linux server
resource "aws_security_group" "aws-ubuntu-sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
  description = "Allow incoming HTTP connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming ICMP"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTPS connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
    Environment = var.app_environment
  }
}
resource "aws_security_group" "aws-centos-sg" {
  name        = "${lower(var.app_name_centos)}-${var.app_environment_centos}-linux-sg"
  description = "Allow incoming HTTP connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming ICMP"
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming SSH connections"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming HTTPS connections"
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming ICMP"
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming HTTP connections"
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming SSH connections"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.11.1.0/24"]
    description = "Allow incoming HTTPS connections"
  }


  tags = {
    Name        = "${lower(var.app_name_centos)}-${var.app_environment_centos}-linux-sg"
    Environment = var.app_environment
  }
}
