resource "aws_route53_record" "dns_name" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.dns_name
  type    = "A"
  ttl     = "300"
  records = var.dns_record_name
}

