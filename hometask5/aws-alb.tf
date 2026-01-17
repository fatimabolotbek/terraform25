resource "aws_lb" "app_alb" {
  name               = "${local.name_prefix}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = local.public_subnet_ids

  tags = merge(var.tags, { Name = "${local.name_prefix}-alb" })
}
