locals {
  tags = {
    name  = var.name
    env   = var.env_name
    owner = "thrinadh"
  }
  name = var.name
}

data "aws_ami" "id" {
  most_recent = true

  filter {
    name   = "thrinadh-ubuntu"
    values = ["ubuntu/images/hvm-ssd/ubuntu-20.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "role" {
  source = "../iam_role"
  name   = local.name
  tags   = local.tags

}

module "vpc" {
  source = "../vpc"
  tags   = local.tags
}

module "sg" {
  source = "../sg"
  name   = local.name
  vpc_id    = module.vpc.id
  tags = local.tags
}

module "s3" {
  source = "../s3"
  name   = local.name
  tags   = local.tags

}
module "ec2" {
  source        = "../ec2"
  name          = local.name
  tags          = local.tags
  instance_type = var.instance_type
  role          = module.role.arn
  vpc_id           = module.vpc.id
  ami_id        = data.aws_ami.id
}

module "alb" {
  source        = "../alb"
  sg            = module.sg.id
  vpc_id        = module.vpc.id
  s3_bucket_arn = module.s3.arn
  name          = local.name
  subnet        = module.ec2.subnet
  ami_id        = data.aws_ami.id
  tags = local.tags
  instance_type = var.instance_type
}

module "secrets" {
  source = "../secrets"
  name   = local.name
  tags   = local.tags
}

module "rds" {
  source      = "../rds"
  db_user     = "${module.secrets.id}:username"
  db_password = "${module.secrets.id}:password"
  tags        = local.tags
}

module "route53" {
  source          = "../route53"
  dns_name        = local.name
  dns_record_name = module.alb.dns_name
}
