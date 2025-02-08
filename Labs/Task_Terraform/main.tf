provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"
  cider_block_range = 16
  subnet_count = 2
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.network.public_subnet_id
  vpc_id = module.network.vpc_id
  
}


