provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"
  cider_block_range = 16
  subnet_count_public = 1
  subnet_count_private = 1

}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.network.public_subnet_id
  vpc_id = module.network.vpc_id
  instance_type = "t2.micro"
  assign_public_ip   = true
}


