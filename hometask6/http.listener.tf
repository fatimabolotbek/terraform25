resource "aws_lb_listener" "https" {
  load_balancer_arn = data.terraform_remote_state.hometask5.outputs.alb_arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = aws_acm_certificate_validation.dnc.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = data.terraform_remote_state.hometask5.outputs.tg_arn
  }
}
