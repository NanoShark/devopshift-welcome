variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0e1bed4f06a3b463d"
}

# receive variables from main
variable "subnet_id" {}
variable "vpc_id" {}