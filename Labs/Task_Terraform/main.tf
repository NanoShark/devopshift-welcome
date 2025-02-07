provider "aws" {
  region = "us-east-1" 
}


module "vpc" {
  source = "./Task_1_VPC/vpc.tf" 
}
