output "vpc_id" {
  value       = aws_vpc.AppVPC.id
  description = "The ID of the main application VPC"
}

output "public_subnet1_id" {
  value       = aws_subnet.public_subnet_1.id
  description = "ID of the public subnet"
}

output "public_subnet2_id" {
  value       = aws_subnet.public_subnet_2.id
  description = "ID of the public subnet"
}

output "private_subnet1_id" {
  value       = aws_subnet.private_subnet_1.id
  description = "ID of the private subnet"
}

output "private_subnet2_id" {
  value       = aws_subnet.private_subnet_2.id
  description = "ID of the private subnet"
}

output "alb_dns_name" {
  value       = aws_lb.web_alb.dns_name
  description = "DNS name of the application Load Balancer"
}

output "alb_arn" {
  value       = aws_lb.web_alb.arn
  description = "ARN of the application Load Balancer"
}

output "web_server_private1_ip" {
  value       = aws_instance.WebServer1.private_ip
  description = "The private IP address of the EC2 web server"
}

output "web_server_private2_ip" {
  value       = aws_instance.WebServer2.private_ip
  description = "The private IP address of the EC2 web server"
}

output "web_server_private1_id" {
  value       = aws_instance.WebServer1.id
  description = "The private ID address of the EC2 web server"
}

output "web_server_private2_id" {
  value       = aws_instance.WebServer2.id
  description = "The private ID address of the EC2 web server"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat.id
  description = "The ID of the NAT Gateway"
}

output "nat_eip" {
  value       = aws_eip.nat_eip.public_ip
  description = "The Elastic IP address of the NAT Gateway"
}

output "instance_profile_name" {
  value       = aws_iam_instance_profile.ec2_profile.name
  description = "The IAM instance profile name attached to the EC2"
}

output "ecr_url" {
  value = data.aws_ecr_repository.app_ecr.repository_url
}

output "ecr_registry" {
  value = data.aws_ecr_repository.app_ecr.registry_id
}

