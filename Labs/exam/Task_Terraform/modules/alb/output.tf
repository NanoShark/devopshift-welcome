

output "michael_alb_dns" {
    description = "DNS Name of the alb"
    value = aws_lb.michael-alb.dns_name
}