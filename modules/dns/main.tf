# Create a Route53 zone for the project
resource "aws_route53_zone" "aws_route53_zone" {
  name = var.domain
}

# Create an A record pointing to the EC2 instance Elastic IP
resource "aws_route53_record" "aws_route53_record" {
  zone_id = aws_route53_zone.aws_route53_zone.zone_id
  name    = var.domain
  type    = "A"
  ttl     = "300"
  records = [var.wordpress_public_ip]
}
