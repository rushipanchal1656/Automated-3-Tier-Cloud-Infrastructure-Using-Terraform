# Automated 3 Tier Web Application Infrastructure on AWS using Terraform

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.24.0"
    }
  }

  backend "s3" {
    bucket = "statefile-backend-s3-bucket-123"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "My_VPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Main_VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.My_VPC.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.az1
  tags = {
    Name = "Public_Subnet"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.My_VPC.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az1
  tags = {
    Name = "Private_Subnet"
  }
}

resource "aws_internet_gateway" "My_IGW" {
  vpc_id = aws_vpc.My_VPC.id  
  tags = {
    Name = "${var.project_name}Main_IGW"
  }
}

resource "aws_default_route_table" "main_rt" {
  default_route_table_id = aws_vpc.My_VPC.default_route_table_id  
  tags = {
    Name = "${var.project_name}Main_RT"
  }
}

resource "aws_route" "my_route" {
  route_table_id         = aws_default_route_table.main_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.My_IGW.id
}

resource "aws_security_group" "My_SG" {
  name        = "${var.project_name}_SG"
  description = "Security group for 3 tier architecture which allows HTTP, HTTPS and SSH"
  vpc_id      = aws_vpc.My_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
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

  tags = {
    Name = "${var.project_name}_SG"
  }
}

resource "aws_instance" "proxy-server" {
  ami           = var.ami_id
  key_name      = var.key_name
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.My_SG.id]  

  tags = {
    Name = "proxy-server"
  }
}

resource "aws_instance" "app-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.My_SG.id]  

  tags = {
    Name = "app-server"
  }
}

resource "aws_instance" "db-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.My_SG.id]  

  tags = {
    Name = "db-server"
  }
}