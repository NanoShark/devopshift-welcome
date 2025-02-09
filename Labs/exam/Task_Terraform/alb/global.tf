
variable "vpc_id" {
  default = ""
}

variable "public_subnets" {
  type = list(string)
  default = [ ]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "target_group_name" {
  default = "michael-target-group"
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 3
}
