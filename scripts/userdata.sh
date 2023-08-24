#!/bin/bash
# Reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hosting-wordpress-aml-2023.html

# Download and install packages
sudo dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y

# Download the latest version of WordPress
sudo wget https://wordpress.org/latest.tar.gz

# Extract the WordPress archive
sudo tar -xzf latest.tar.gz

# Delete the archive after extracting it
sudo rm -rf latest.tar.gz

# Start the database and web server
sudo systemctl start mariadb httpd

# Create a database and database user for WordPress
sudo mysql -u root -p  -e "CREATE USER 'wordpress-user'@'localhost' IDENTIFIED BY 'wordress'; CREATE DATABASE 'wordpress-db'; GRANT ALL PRIVILEGES ON 'wordpress-db'.* TO "wordpress-user"@"localhost"; FLUSH PRIVILEGES;"

# Create and edit the WordPress configuration file (wp-config.php)
sudo cp wordpress/wp-config-sample.php wordpress/wp-config.php

# Install WordPress under the /var/www/html directory (Apache document root)
sudo cp -r wordpress/* /var/www/html/

# Install PHP graphics drawing library
sudo yum install php-gd

# Fix file permissions for the Apache web server
sudo chown -R apache /var/www
sudo chgrp -R apache /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0644 {} \;

# Restart the Apache web server
sudo systemctl restart httpd
sudo systemctl enable httpd && sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo systemctl start httpd

# TODO: Connect to the EC2 instance using SSM Session Manager and follow the instructions below.

# Edit the following lines in the wp-config.php file
# using `sudo nano wordpress/wp-config.php`
#   define('DB_NAME', 'wordpress-db');
#   define('DB_USER', 'wordpress-user');
#   define('DB_PASSWORD', 'wordpress');
#
# In the same file, find the section called `Authentication Unique Keys and Salts`
# Replace the values in that section with the output from the following command
# curl -s https://api.wordpress.org/secret-key/1.1/salt/
#   define('AUTH_KEY',         ' #U$$+[RXN8:b^-L 0(WU_+ c+WFkI~c]o]-bHw+)/Aj[wTwSiZ<Qb[mghEXcRh-');
#   define('SECURE_AUTH_KEY',  'Zsz._P=l/|y.Lq)XjlkwS1y5NJ76E6EJ.AV0pCKZZB,*~*r ?6OP$eJT@;+(ndLg');
#   define('LOGGED_IN_KEY',    'ju}qwre3V*+8f_zOWf?{LlGsQ]Ye@2Jh^,8x>)Y |;(^[Iw]Pi+LG#A4R?7N`YB3');
#   define('NONCE_KEY',        'P(g62HeZxEes|LnI^i=H,[XwK9I&[2s|:?0N}VJM%?;v2v]v+;+^9eXUahg@::Cj');
#   define('AUTH_SALT',        'C$DpB4Hj[JK:?{ql`sRVa:{:7yShy(9A@5wg+`JJVb1fk%_-Bx*M4(qc[Qg%JT!h');
#   define('SECURE_AUTH_SALT', 'd!uRu#}+q#{f$Z?Z9uFPG.${+S{n~1M&%@~gL>U>NV<zpD-@2-Es7Q1O-bp28EKv');
#   define('LOGGED_IN_SALT',   ';j{00P*owZf)kVD+FVLn-~ >.|Y%Ug4#I^*LVd9QeZ^&XmK|e(76miC+&W&+^0P/');
#   define('NONCE_SALT',       '-97r*V/cgxLmp?Zy4zUU4r99QQ_rGs2LTd%P;|_e1tS)8_B/,.6[=UK<J_y9?JWG');


# Allow Wordpress to use permalinks
# using `sudo vim /etc/httpd/conf/httpd.conf` and modify the AllowOverride directive
#   <Directory "/var/www/html">
#       AllowOverride All
#   </Directory>
