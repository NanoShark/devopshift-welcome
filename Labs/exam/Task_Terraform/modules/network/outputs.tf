output "vpc_id" {
  value = aws_vpc.michael_vpc.id
}

output "public_subnet_id" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}
