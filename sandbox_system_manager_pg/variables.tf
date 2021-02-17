#
# Terraform
#

variable "environment" {
  description = "Environment for TAG"
  type        = string
}

variable "backup" {
  description = "Backup Tag for AMI Creation"
  type        = string
}

variable "backup_no_Reboot" {
  description = "Backup Tag for AMI Creation"
  type        = bool
}

variable "backup_retention_days" {
  description = "Backup Tag for AMI Creation"
  type        = number
}

# Destroy protection
variable "destroy_protection" {
  description = "Destroy protection"
  type        = bool
}

# VPC ID
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# Key Pair Setup

variable "key_name" {
  description = "EC2 key_name"
  type        = string
}

#
# EC2 Variables
#

variable "ec2_associate_public_ip_address" {
  description = "EC2 Associate Public IP Address"
  type        = list
}

variable "ec2_vpc_security_group_ids" {
  description = "EC2 Instance VPC Security Group IDs"
  type        = string
}

variable "ec2_subnet_id" {
  description = "EC2 Instance Subnet IDs"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 Instance Size"
  type        = list
}

variable "ec2_volume_type" {
  description = "EC2 Volume Type"
  type        = string
}

variable "ec2_volume_size" {
  description = "EC2 Volume size in GB"
  type        = list
}

variable "ec2_name" {
  description = "EC2 Name"
  type        = list
}

