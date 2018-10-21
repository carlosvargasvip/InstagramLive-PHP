#!/bin/sh

# install-IGLive.sh
# author: Carlos Vargas
# info@carlosvargas.com

# Create Directory
md instagramlive
cd instagramlive

# Download Composer.phar

EXPECTED_SIGNATURE="$(curl https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
#exit $RESULT

# Download Code for InstagramLive
curl https://github.com/carlosvargasvip/InstagramLive-PHP/archive/master.zip -L -o instagramlive.zip

# Unziping files to Instagram-Live-PHP
unzip instagramlive.zip

# Set Code in the correct directory
cd InstagramLive-PHP-Master
mv * ../
cd ..
rm -rf InstagramLive-PHP-Master

# Download Required Packages
./composer.phar install

# Open config.php to add Instagram Credentials
open -t config.php 

# Wait 2 Minutes to Instagram Creditials
echo "Waiting for Instagram credentials"

# Instructions after Credentials have been entered
echo "type php goLive.php to go Live on Instagram"
