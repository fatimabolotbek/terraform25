resource "aws_sqs_queue" "main" {
  for_each = toset(var.names) /// map or set of string (tuple)
  name = each.key
}

variable "names" {
    type = list(string)
    description = "This variable sqs queue names"
    default = [ "queue-1", "queue-2" ]
  
}

resource "aws_sqs_queue" "new" {
    for_each = toset(var.names)
    name = each.key
  
}
/// for = transverm value

locals {
  names = [ for a in range(1,2) : "new-queue-${a}"]
}


resource "aws_security_group" "main" {
  name        = "aws-session-sg"
  description = "This is a security group for an ec2 instance"


}

resource "aws_security_group_rule" "main" {
  for_each =  local.services
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [each.value.cidr_blocks]
  security_group_id = aws_security_group.main.id
}

variable "services" {
  default = [
    { name = "ssh", port = 22, cidr_blocks = "10.0.0.0/16"},
    { name = "web", port = 80, cidr_blocks = "0.0.0.0/0" }
  ]
}

locals {
  services = {
    for svc in var.services : svc.name => {port = svc.port, cidr_blocks = svc.cidr_blocks}
  }
  }
