variable "ami_id" {
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
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.vpc_security_group_ids
  
  
  tags = {
    Name = var.instance_name
  }

  # Disable key pair
  key_name = null

  # Install Docker
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo chkconfig docker on
  EOF
}