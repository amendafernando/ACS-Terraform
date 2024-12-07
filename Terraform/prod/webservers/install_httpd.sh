#!/bin/bash
yum -y update
yum -y install httpd

# Download the image from S3
curl -o /var/www/html/picture.jpg https://group3-terraform-state-dev-sh.s3.us-east-1.amazonaws.com/picture.jpg

# Check if the image was downloaded successfully
if [ -f /var/www/html/picture.jpg ]; then
    echo "Image downloaded successfully" >> /var/log/user-data.log
else
    echo "Image download failed" >> /var/log/user-data.log
fi

# Create the HTML file to display the image
echo "<!DOCTYPE html>
<html>
<head>
  <title>Welcome</title>
</head>
<body>
  <h1>Welcome to ACS730 Assignment 2 WebServer!</h1>
  <p>Private IP is $(hostname -I | awk '{print $1}')</p>
  <img src='picture.jpg' alt='Webserver Image' />
  <p>Built by Terraform!</p>
</body>
</html>" > /var/www/html/index.html

# Start and enable the web server
sudo systemctl start httpd
sudo systemctl enable httpd
