variable "availability_zone" {
  type        = list(string)
  default     = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d" , "us-east-1e" , "us-east-1f"]
}
variable "cider_block_range" {
  default = 16
}



variable "subnet_count_public" {
  default = 1
}

variable "subnet_count_private" {
  default = 1
}