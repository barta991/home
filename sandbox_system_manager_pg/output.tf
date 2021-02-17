output "keypair" {
  description = "EC2 Key Pair Name"
  value       = aws_key_pair.unzer-keypair.key_name
}

output "keypair_private_key" {
  description = "EC2 Key Pair Private Key"
  value       = tls_private_key.unzer-keypair.private_key_pem
}

output "ec2_instance_public_ip" {
  description = "List of private IPs of EC2 instances"
  value       = aws_instance.tb_sandbox.*.associate_public_ip_address
}