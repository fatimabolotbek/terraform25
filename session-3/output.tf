output "instance_ip_addr" {
  value       = aws_instance.main.id
  description = "This is ec2 instance ids"
}