#!/bin/bash
# Reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hosting-wordpress-aml-2023.html

# Download and install packages
dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y

# Download the latest version of WordPress
wget https://wordpress.org/latest.tar.gz

# Extract the WordPress archive
tar -xzf latest.tar.gz

# Delete the archive after extracting it
rm -rf latest.tar.gz

# Start the database and web server
sudo systemctl start mariadb httpd
