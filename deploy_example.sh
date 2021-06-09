#!/bin/sh

########################################################
# Bash script to install HeavyGari Laravel App
# Written by Talha Ibne Imam
########################################################

HC='\033[0;32m' # Heading Color
WC='\033[0;33m' # Warning Color
NC='\033[0m' # No Color

DATABASE="YOUR DATABASE NAME"
FOLDER="YOUR PROJECT NAME"
GIT_URL="URL OF YOUR GIT REPO" # (i.e. https://cse031sust02@bitbucket.org/xyz.git)

echo -e "${HC}::::::::::::::::::::::::::Creating Database::::::::::::::::::::::::::${NC}"
read -p "Please enter password for MySQL root user :" mysqlpasswd
mysql -uroot -p${mysqlpasswd} -e "CREATE DATABASE ${DATABASE}"

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

echo -e "${HC}::::::::::::::::::::::::::Database Setup::::::::::::::::::::::::::${NC}"
read -p "PLEASE FIRST UPLOADE YOUR .env FILE TO SERVER AND THEN PRESS y : " answer
case ${answer:0:1} in
    y|Y )
        echo -e "${HC}::::::::::::::::::::::::::Database Migration::::::::::::::::::::::::::${NC}"
        sudo php artisan migrate

        echo -e "${HC}::::::::::::::::::::::::::Seed Database::::::::::::::::::::::::::${NC}"
        sudo php artisan db:seed
    ;;
    * )
        echo  -e "${WC}>PLEASE REMEMBER TO UPLOAD .env FILE ON SERVER THEN MIGRATE & SEED THE DATABASE LATER${NC}"
    ;;
esac

echo -e "${HC}::::::::::::::::::::::::::Configuring Nginx::::::::::::::::::::::::::${NC}"
sudo touch /etc/nginx/sites-available/${FOLDER}
sudo chown -R ubuntu:ubuntu /etc/nginx/sites-available/${FOLDER}
sudo cat > /etc/nginx/sites-available/${FOLDER} <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html/${FOLDER}/public;
    index index.php index.html;
    server_name _;
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }
    # pass the PHP scripts to FastCGI server
    #
    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    }
}
EOF
sudo ln -s /etc/nginx/sites-available/${FOLDER} /etc/nginx/sites-enabled/
sudo service nginx restart

echo -e "${HC}::::::::::::::::::::::::::All Completed::::::::::::::::::::::::::${NC}"
