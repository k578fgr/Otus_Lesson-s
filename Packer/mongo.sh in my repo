#!/bin/bash
#Ubuntu version 18.04 bionic
#startup http server with ruby
sudo apt update
sudo apt upgrade -y
cd ~
#Install Ruby and Bundler
sudo apt install -y ruby-full ruby-bundler build-essential -y
#Add keyserver
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
#Add mongo
FILE=~/mongodb-org-server_3.6.20_amd64.deb
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    wget https://mirror.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/3.6/multiverse/binary-amd64/mongodb-org-server_3.6.20_amd64.deb
fi
sudo chmod +x mongodb-org-server_3.6.20_amd64.deb
sudo dpkg -i mongodb-org-server_3.6.20_amd64.deb
sudo systemctl start mongod
sudo systemctl enable mongod
sudo apt install git -y
sudo apt update
sudo apt upgrade -y
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
sudo iptables -t filter -A INPUT -p tcp --dport 9292 -j ACCEPT
