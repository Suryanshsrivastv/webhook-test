output "dns_name" {
  value = aws_lb.backend.dns_name
}

output "zone_id" {
  value = aws_lb.backend.zone_id
}