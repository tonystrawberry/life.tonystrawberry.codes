output "wordpress_public_ip" {
  value = aws_eip.aws_eip.public_ip
}
