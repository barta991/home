################################### Provider configuration ###################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0.0"
    }
  }
  backend "s3" {
     bucket = "unzer-s3-sandbox"
     region = "eu-central-1"
     key    = "sandbox/terraform.tfstate"
  }
}

provider "aws" {
  region  = "eu-central-1"
}

################################### Generates a secure private key ###################################
resource "tls_private_key" "unzer-keypair" {
  algorithm = "RSA"
}

################################### EC2 Key Pair ###################################
resource "aws_key_pair" "unzer-keypair" {
  key_name   = "unzer-ec2-keypair-${lower(var.environment)}"
  public_key = tls_private_key.unzer-keypair.public_key_openssh
  
  tags       = {
    Environment = var.environment
    Terraform   = "true"
  }
}

################################### EC2 Config ###################################

resource "aws_instance" "tb_sandbox" {

#instance_type = "t2.micro"

count = length(var.ec2_instance_type)

instance_type = var.ec2_instance_type[count.index]

ami = "ami-009b16df9fcaac611"
iam_instance_profile        = "ManagedInstancesRole"

vpc_security_group_ids      = [var.ec2_vpc_security_group_ids]
subnet_id                   = var.ec2_subnet_id
associate_public_ip_address = var.ec2_associate_public_ip_address[count.index]
disable_api_termination     = var.destroy_protection
key_name                    = aws_key_pair.unzer-keypair.key_name
user_data                   = file("install_ssm_agent.sh")
  root_block_device {
    volume_type = var.ec2_volume_type
    volume_size = var.ec2_volume_size[count.index]
  }

  tags = {
    Environment = var.environment
    Name        = var.ec2_name[count.index]
    Terraform   = "true"
    Backup      = var.backup
    BackupNoReboot = var.backup_no_Reboot
    BackupRetentionDays = var.backup_retention_days
}
}

################################### LB Config ###################################
resource "aws_lb" "tb_sandbox_lb" {
  name               = "tb-sandbox-lb"
  internal           = false
  load_balancer_type = "network"
  
  subnet_mapping {
    subnet_id     = var.ec2_subnet_id
  }

  enable_deletion_protection = true

  tags = {
    Environment = "sandbox"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.tb_sandbox_lb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tb_sandbox_tg.arn
  }
}
################################### TG Config ###################################
resource "aws_lb_target_group" "tb_sandbox_tg" {
  name     = "tb-sandbox-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

################################### TG Attachment Config ###################################
resource "aws_lb_target_group_attachment" "tb_sandbox_tg" {
  count            = 2
  target_group_arn = aws_lb_target_group.tb_sandbox_tg.arn
  target_id        = aws_instance.tb_sandbox[count.index].id
  port             = 80
}