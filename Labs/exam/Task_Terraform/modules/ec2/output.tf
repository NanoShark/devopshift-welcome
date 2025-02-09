output "vm_public_ip" {
  value = [for instance in aws_instance.michael-instance : instance.public_ip]
  description = "Public IP address"
}

