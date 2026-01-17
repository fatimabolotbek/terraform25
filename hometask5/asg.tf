resource "aws_autoscaling_group" "asg" {
  name                = "${local.name_prefix}-asg"
  min_size            = 1
  max_size            = 3
  desired_capacity    = 2
  vpc_zone_identifier = local.private_subnet_ids

  target_group_arns = [aws_lb_target_group.tg.arn]

  launch_template {
    id = aws_launch_template.app.id

    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 120

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg-instance"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
