#!/bin/bash
service mysql start

mysql -u root --skip-password -e "CREATE USER 'ft_server'@'localhost' IDENTIFIED BY 'ft_server';"
mysql -u root --skip-password -e "CREATE DATABASE wordpress;"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'ft_server'@'localhost' IDENTIFIED BY 'ft_server';"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"

mkdir /var/www/phpmyadmin
wget -c -t inf --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz -O phpmyadmin.tar.gz
tar -xvf phpmyadmin.tar.gz --strip-components 1 -C /var/www/phpmyadmin
rm -rf phpmyadmin.tar.gz

mkdir /var/www/wordpress
wget -c -t inf --no-check-certificate https://wordpress.org/latest.tar.gz -O wordpress.tar.gz
tar -xvf wordpress.tar.gz --strip-components 1 -C /var/www/wordpress
rm -rf wordpress.tar.gz

mkdir /etc/nginx/ssl
openssl req -x509 -nodes -newkey rsa:2048 -sha256 -out /etc/nginx/ssl/local.pem -keyout /etc/nginx/ssl/local.key -subj "/C=RU/ST=NSO/L=Moscow/O=21school/CN=localhost/emailAddress=brattles@student.21school.ru"

chown -R www-data /var/www/* && chmod -R 755 /var/www/*

service php7.3-fpm start
nginx -g "daemon off;"