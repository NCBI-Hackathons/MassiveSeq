#!/bin/bash

# install Apache, MySQL, PHP

sudo apt update
sudo apt install apache2
sudo ufw allow in "Apache Full"

sudo apt install mysql-server

sudo mysql_secure_installation
sudo mysql
sudo apt install php libapache2-mod-php php-mysql


#sudo vi /etc/apache2/mods-enabled/dir.conf
