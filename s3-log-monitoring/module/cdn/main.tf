resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = "s3-origin"
  }

  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = var.viewer_protocol_policy

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.ssl_support_method
  }

  enabled = var.enabled
}
