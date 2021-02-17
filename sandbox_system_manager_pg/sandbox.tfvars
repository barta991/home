# DEV
environment                                         = "sandbox"
backup                                              = "yes"
backup_no_Reboot                                    = true
backup_retention_days                               = 2

# General
destroy_protection                                  = false
vpc_id                                              = "vpc-edd0ce86"
key_name                                            = "tb_sandbox"

# EC2 Variables
ec2_associate_public_ip_address                     = ["true", "true",]
ec2_vpc_security_group_ids                          = "sg-02b63ba8d66cf5b3b"
ec2_subnet_id                                       = "subnet-10787b5d"
ec2_instance_type                                   = ["t2.micro", "t2.micro"]
ec2_volume_type                                     = "gp2"
ec2_volume_size                                     = ["20", "20"]
ec2_name                                            = ["tb_sandbox_1", "tb_sandbox_2"]
