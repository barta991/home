#!/bin/bash

#Install SSM Agent
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

#Create index.html
sudo su -
sudo echo "Hello, World" > /var/www/html/index.html

echo "SSM Agent installed"
echo "Index.html setup done"