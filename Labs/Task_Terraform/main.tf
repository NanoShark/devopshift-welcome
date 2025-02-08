provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_id
  vpc_id             = module.vpc.vpc_id
  
}
