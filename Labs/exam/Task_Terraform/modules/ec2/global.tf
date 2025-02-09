variable "instance_type" {
  default = "t3.micro"
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

variable "assign_public_ip" {
  default     = true
}