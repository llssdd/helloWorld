#!/bin/sh

########################################################
# Bash script to install HeavyGari Laravel App
# Written by Talha Ibne Imam
########################################################

HC='\033[0;32m' # Heading Color
WC='\033[0;33m' # Warning Color
NC='\033[0m' # No Color

PATH=/var/www/your_domain/
FOLDER="helloWorld"
GIT_URL="https://github.com/llssdd/helloWorld.git" # (i.e. https://cse031sust02@bitbucket.org/xyz.git)

if [ -d ${PATH} ${FOLDER}]
then
    echo "Directory $PATH $FOLDER exists"
else
    echo "Error: Directory $PATH $FOLDER does not exists."
fi
echo -e "${HC}::::::::::::::::::::::::::Creating Project Directory::::::::::::::::::::::::::${NC}"
cd /var/www/your_domain/ ${FOLDER}
echo -e "${HC}::::::::::::::::::::::::::In Project Directory::::::::::::::::::::::::::${NC}"
