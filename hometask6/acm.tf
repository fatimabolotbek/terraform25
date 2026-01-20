resource "aws_acm_certificate" "acm" {
  domain_name       = var.root_domain_name
  subject_alternative_names = [ "*.phonedomain.net"]
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
  
}
////// Rout53 record //////
resource "aws_route53_record" "dnc_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "dnc" {
  certificate_arn         = aws_acm_certificate.acm.arn
  validation_record_fqdns = [for record in aws_route53_record.dnc_record : record.fqdn]
}


resource "aws_route53_record" "alias" {
  zone_id = var.zone_id
  name    = var.root_domain_name
  type    = "A"

  allow_overwrite = true

  alias {
    name                   = data.terraform_remote_state.hometask5.outputs.alb_dns_name
    zone_id                = data.terraform_remote_state.hometask5.outputs.alb_zone_id
    evaluate_target_health = true
  }
}
