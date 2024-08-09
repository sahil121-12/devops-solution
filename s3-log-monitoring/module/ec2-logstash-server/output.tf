output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.logstash.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.logstash.public_ip
}

output "public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.logstash.public_dns
}
output "security_group_id" {
  value = aws_security_group.logstash_sg.id
}

output "security_group_name" {
  value = aws_security_group.logstash_sg.name
}
