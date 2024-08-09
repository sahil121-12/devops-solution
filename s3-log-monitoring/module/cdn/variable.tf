variable "origin_domain_name" {
  description = "The domain name of the origin, e.g., an S3 bucket's regional domain name"
  type        = string
}

variable "allowed_methods" {
  description = "The list of allowed methods for the cache behavior"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cached_methods" {
  description = "The list of cached methods for the cache behavior"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "viewer_protocol_policy" {
  description = "The policy for viewers connecting to the CloudFront distribution"
  type        = string
  default     = "redirect-to-https"
}

variable "enabled" {
  description = "Whether the CloudFront distribution is enabled"
  type        = bool
  default     = true
}

variable "geo_restriction_type" {
  description = "The type of geo restriction (e.g., 'whitelist', 'blacklist', 'none')"
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "The list of locations (ISO 3166-1 alpha-2 codes) to apply geo restrictions"
  type        = list(string)
  default     = []
}

variable "cloudfront_default_certificate" {
  description = "Whether to use the default CloudFront SSL/TLS certificate"
  type        = bool
  default     = true
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate to use with the distribution"
  type        = string
  default     = ""
}

variable "ssl_support_method" {
  description = "The security policy that CloudFront uses for HTTPS connections"
  type        = string
  default     = "sni-only"
}
