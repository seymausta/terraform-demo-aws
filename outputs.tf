output "instance_hostname" {
  description = "Private DNS name of the EC2 instance."
  value       = aws_instance.ec2demo.private_dns
}

output "public_ip" {
  value = aws_instance.ec2demo.public_ip
}