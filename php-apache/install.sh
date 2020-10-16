#!/bin/bash 

cd /var/www/html


	

git clone https://github.com/q2a/question2answer.git qa

cd qa

cp qa-config-example.php qa-config.php 
cp .htaccess-example .htaccess

echo "define('QA_WORDPRESS_INTEGRATE_PATH', '/var/www/html');" >> qa-config.php 
echo "" >> qa-config.php 