variable "region" {
  default = "ap-south-1"
}

variable "az1" {
  default = "ap-south-1a"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/20"
}

variable "private_subnet_cidr" {
  default = "10.0.16.0/20"
}


variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0d176f79571d18a8f" # Amazon Linux 2 AMI (HVM), SSD Volume Type
}

variable "key_name" {
  default = "Mumbai_server_key"
}

variable "project_name" {
  default = "Three_Tier_Architecture"
}
