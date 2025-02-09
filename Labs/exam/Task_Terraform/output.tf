output "vpc_output" {
  value = module.network
}

output "ec2_output" {
  value = module.ec2
}

output "alb_output" {
  value = module.michael-alb
}