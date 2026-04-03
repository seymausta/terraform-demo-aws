output "instance_hostname" {
  description = "Private DNS name of the EC2 instance."
  value       = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}