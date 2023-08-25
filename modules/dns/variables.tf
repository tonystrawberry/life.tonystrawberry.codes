variable "domain" {
  description = "The domain to use for the DNS zone"
  type        = string
  default     = "tonystrawberry.codes"
}

variable "wordpress_public_ip" {
  description = "The Elastic IP address to use for the DNS zone"
  type        = string
}
