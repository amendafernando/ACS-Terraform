#!/bin/bash
yum -y update
yum -y install httpd

echo "<h1>Welcome to ACS730 Assignment 2 WebServer!</h2> Private IP is $(hostname -I | awk '{print $1}')' <br><br>Built by Terraform!"  >  /var/www/html/index.html

sudo systemctl start httpd
sudo systemctl enable httpd