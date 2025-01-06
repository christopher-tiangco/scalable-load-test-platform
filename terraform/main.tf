# Create IAM role and attach the policy to enable SSM agent on the EC2 instance
module "iam_roles_and_policies" {
  source = "./iam"
}

# Create a VPC SecurityGroup that accepts inbound and outbound SSH connections from/to anywhere
module "security_group" {
  source = "./security_group"
  
  vpc_id              = local.config.vpc.id
  security_group_name = "load_test_platform_sg"
}

# Create the EC2 instance
module "ec2" {
  source = "./ec2"
  
  ami_id                  = local.config.ec2.ami_id
  instance_name           = local.config.ec2.name
  instance_profile        = module.iam_roles_and_policies.ssm_role_instance_profile_name
  instance_type           = local.config.ec2.instance_type
  ec2_key_pair            = local.config.ec2.key_pair
  subnet_id               = local.config.vpc.subnet_id
  vpc_security_group_ids  = ["${module.security_group.id}"]
}