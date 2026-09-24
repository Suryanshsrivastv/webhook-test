module "vpc" {
  source = "./modules/vpc"
}

module "security_gp" {
  source = "./modules/security_gp"
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"
}

module "secrets-manager" {
  source      = "./modules/secrets-manager"
  db_password = var.db_password
}

module "iam" {
  source         = "./modules/iam"
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = "ap-south-1"
  db_secret_arn  = module.secrets-manager.secret_arn
}

module "rds" {
  source              = "./modules/rds"
  private_subnet_ids  = module.vpc.private_subnet_db_ids
  rds_sg_id           = module.security_gp.rds_sg_id
  db_username         = module.secrets-manager.db_username
  db_password         = module.secrets-manager.db_password
}

module "asg-backend" {
  source                 = "./modules/asg-backend"
  ami_id                 = var.ami_id
  subnet_id              = module.vpc.public_subnet_app_id
  backend_sg_id          = module.security_gp.backend_sg_id
  instance_profile_name  = module.iam.backend_instance_profile_name
  ecr_repo_url           = module.ecr.repository_url
  aws_region             = "ap-south-1"
  db_secret_arn          = module.secrets-manager.secret_arn
  db_host                = split(":", module.rds.db_endpoint)[0]
  db_name                = var.db_name
}

module "jenkins-ec2" {
  source                 = "./modules/jenkins-ec2"
  ami_id                 = var.ami_id
  subnet_id              = module.vpc.public_subnet_cicd_id
  jenkins_sg_id           = module.security_gp.jenkins_sg_id
  instance_profile_name  = module.iam.jenkins_instance_profile_name
}

module "s3-frontned" {
  source = "./modules/s3-frontned"
}

data "aws_caller_identity" "current" {}