variable "vpc_id" {
  type = string
}

variable "security_group_name" {
  type = string
}

resource "aws_security_group" "load_test_platform_sg" {
  name      = var.security_group_name
  vpc_id    = var.vpc_id
  tags = {
    Name = var.security_group_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "load_test_platform_sg_ingress" {
  security_group_id             = aws_security_group.load_test_platform_sg.id
  ip_protocol                   = "tcp"
  from_port                     = 22
  to_port                       = 22
  cidr_ipv4                     = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "load_test_platform_sg_egress" {
  security_group_id = aws_security_group.load_test_platform_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

output "id" {
  value = aws_security_group.load_test_platform_sg.id
}