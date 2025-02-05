provider "aws" {
 region = var.region
}

variable "region" {
 default = "us-east-1"
}

data "aws_ami" "terraform_ami" {
  owners = ["self"]
  filter {
    name = "name"
    values = ["terraform-workshop-image-do-not-delete"]
  }
}

data "aws_ami" "my_privateami"{
  owners = ["self"] 
  
}


output "Michael_ami" {
  value = data.aws_ami.my_privateami

}
output "terraformimage" {
  value = data.aws_ami.terraform_ami.id
}

variable "ami" {
 default = "ami-0ecc0e0d5986a576d"
 }

variable "vm_name" {
 default = "vm-Michael"
}

variable "admin_username" {
 default = "admin-user"
}

variable "admin_password" {
 default = "Password123!"
}

variable "vm_size" {
 default = "t2.micro"
}
