/*module "create_ec2" {
  source = "./modules"
  ami = "ami-0c02fb55956c7d316"
  machine_type = "t2.micro"
}

output "print_module_ami" {
  value = module.create_ec2.print_ami
}
output "print_module_publicIP" {
  value = module.create_ec2.vm_public_ip
}
output "print_module_region" {
  value = module.create_ec2.print_region
}
provider "aws" {
  region = "us-east-1"  # Change this to your region
}
*/


/*
MODULE LAB:


Transform the following ec2 manifest to a module using as many vars as possible (required)
Don’t forget to print the machine PUBLIC IP ,AMI and REGION


Use vars without default values BESIDE the region (for the region also add default value)

My code sample: 
https://github.com/yanivomc/devopshift-welcome/tree/workshop/terraform/mylab/lab500/labmodule

*/

//option 1

/*variable "s3_buckets" {
  type = map(bool)
  default = {
    "prod" = true
    "dev" = false
  }
}

resource "aws_s3_bucket" "buckets" {
  for_each = { for key, value in var.s3_buckets : key => value if value }

  bucket = "my-app-${each.key}"
  acl    = "private"

  tags = {
    Name        = "Bucket for ${each.key}"
    Environment = "${each.key}"
  }
}
*/


//option 2 

variable "enabled_services" {
  type    = list(string)
  default = ["prod"]
}
variable "s3_buckets" {
  type    = set(string)
  default = ["prod", "dev"]
}
resource "aws_s3_bucket" "buckets" {
  for_each = { for key in var.s3_buckets : key => key if contains(var.enabled_services, key) }
  bucket = "my-app-${each.key}"
  acl    = "private"
  tags = {
    Name        = "Bucket for ${each.key}"
    Environment = each.key
  }
}

