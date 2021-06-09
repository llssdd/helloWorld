#!/bin/sh

DIR="/var/www/your_domain"
FOLDER="helloWorld"
GIT_URL="https://github.com/llssdd/helloWorld.git" # (i.e. https://cse031sust02@bitbucket.org/xyz.git)

echo -e "${HC}::::::::::::::::::::::::::Creating Project Directory::::::::::::::::::::::::::${NC}"

if [ -d "${DIR}/${FOLDER}" ]; then
  # Take action if $DIR exists. #
  echo "Dont need to create directory: ${DIR}/${FOLDER}"
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Error: ${DIR}/${FOLDER} not found. Creating directory."
  cd $DIR
  mkdir $FOLDER
  exit 1
fi

echo -e "${HC}::::::::::::::::::::::::::Project Directory Created::::::::::::::::::::::::::${NC}"
cd "${DIR}/${FOLDER}"
echo -e "${HC}We are in folder: $(pwd)${NC}"

echo -e "${HC}::::::::::::::::::::::::::In Project Directory::::::::::::::::::::::::::${NC}"

if cd repo; then git pull; else git clone https://github.com/llssdd/helloWorld.git repo; fi
