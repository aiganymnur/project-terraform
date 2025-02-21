provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# VPC
resource "aws_vpc" "group3_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
  Name = "group-3"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "group3_igw" {
  vpc_id = aws_vpc.group3_vpc.id

  tags = {
  Name = "group-3-igw"
  }
}

# Route Table
resource "aws_route_table" "group3_rt" {
  vpc_id = aws_vpc.group3_vpc.id

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.group3_igw.id
  }
tags = {
  Name = "group-3-rt"
  }
}

# Create 3 Public Subnets
resource "aws_subnet" "group3_subnet_1" {
  vpc_id = aws_vpc.group3_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
  Name = "group3-subnet-1"
  }
}
resource "aws_subnet" "group3_subnet_2" {
  vpc_id = aws_vpc.group3_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
  Name = "group3-subnet-2"
  }
}

resource "aws_subnet" "group3_subnet_3" {
  vpc_id = aws_vpc.group3_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1c"

  tags = {
  Name = "group3-subnet-3"
  }
}

# Associate Subnets with Route Table
resource "aws_route_table_association" "group3_assoc_1" {
  subnet_id  = aws_subnet.group3_subnet_1.id
  route_table_id = aws_route_table.group3_rt.id
}

resource "aws_route_table_association" "group3_assoc_2" {
  subnet_id  = aws_subnet.group3_subnet_2.id
  route_table_id = aws_route_table.group3_rt.id
}

resource "aws_route_table_association" "group3_assoc_3" {
  subnet_id  = aws_subnet.group3_subnet_3.id
  route_table_id = aws_route_table.group3_rt.id
}


# Security Group for EC2 and RDS
resource "aws_security_group" "group3_sg" {
  vpc_id = aws_vpc.group3_vpc.id
  name  = "group-3-sg"

  ingress {
  from_port  = 22
  to_port  = 22
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Limit this in production
  }

  ingress {
  from_port  = 80
  to_port  = 80
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Fetch Latest Amazon Linux 2 AMI
data "aws_ami" "linux_ami" {
  most_recent = true
  owners  = ["amazon"]

  filter {
  name  = "name"
  values = ["amzn2-ami-hvm-*"]
  }
}

# Create EC2 Instance
resource "aws_instance" "group3_instance" {
  ami  = data.aws_ami.linux_ami.id
  instance_type  = "t2.micro"
  subnet_id  = aws_subnet.group3_subnet_1.id
  vpc_security_group_ids = [aws_security_group.group3_sg.id]
  user_data = file("apache.sh")

  tags = {
  Name = "group-3"
  }

}
