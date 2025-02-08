variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0e1bed4f06a3b463d"
}

variable "subnet_id" {
  type = list(string)
  default = []
}

variable "vpc_id" {
  default = ""
}