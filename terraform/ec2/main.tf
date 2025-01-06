variable "ami_id" {
  type = string
}

variable "ec2_key_pair" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_profile" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}


resource "aws_instance" "load_test_platform" {
  ami                     = var.ami_id
  iam_instance_profile    = var.instance_profile
  instance_type           = var.instance_type
  key_name                = var.ec2_key_pair
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.vpc_security_group_ids
  
  
  tags = {
    Name = var.instance_name
  }

  # Install Docker and Git then clone the repository for this terraform configuration
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo chkconfig docker on
  EOF
}