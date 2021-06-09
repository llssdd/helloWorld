#!/bin/sh

########################################################
# Bash script to install HeavyGari Laravel App
# Written by Talha Ibne Imam
########################################################

HC='\033[0;32m' # Heading Color
WC='\033[0;33m' # Warning Color
NC='\033[0m' # No Color

FOLDER="helloWorld"
GIT_URL="https://github.com/llssdd/helloWorld.git" # (i.e. https://cse031sust02@bitbucket.org/xyz.git)


echo -e "${HC}::::::::::::::::::::::::::Creating Project Directory::::::::::::::::::::::::::${NC}"
cd /var/www/html
sudo mkdir ${FOLDER}
sudo chown -R ubuntu:ubuntu ${FOLDER}

echo -e "${HC}::::::::::::::::::::::::::Cloning Git Repo::::::::::::::::::::::::::${NC}"
git clone ${GIT_URL} ${FOLDER}
cd /var/www/html/${FOLDER}

echo -e "${HC}::::::::::::::::::::::::::Composer Install::::::::::::::::::::::::::${NC}"
composer install --optimize-autoloader

echo -e "${HC}::::::::::::::::::::::::::Setting Permissions::::::::::::::::::::::::::${NC}"
sudo chmod -R 0775 /var/www/html/${FOLDER}/storage
sudo chmod -R 0775 /var/www/html/${FOLDER}/bootstrap/cache
sudo chown -R ubuntu:www-data /var/www/html/${FOLDER}/storage

echo -e "${HC}::::::::::::::::::::::::::Creating Storage Directory::::::::::::::::::::::::::${NC}"
sudo php artisan storage:link

echo -e "${HC}::::::::::::::::::::::::::Configuring Nginx::::::::::::::::::::::::::${NC}"
sudo touch /etc/nginx/sites-available/${FOLDER}
sudo chown -R ubuntu:ubuntu /etc/nginx/sites-available/${FOLDER}

sudo ln -s /etc/nginx/sites-available/${FOLDER} /etc/nginx/sites-enabled/
sudo service nginx restart

echo -e "${HC}::::::::::::::::::::::::::All Completed::::::::::::::::::::::::::${NC}"
