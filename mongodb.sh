#!/bin/bash
set -e

# Install MongoDB
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
wget http://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/3.6/multiverse/binary-amd64/mongodb-org-server_3.6.21_amd64.deb
chmod +x mongodb-org-server_3.6.21_amd64.deb
dpkg -i mongodb-org-server_3.6.21_amd64.deb
apt-get update
apt-get upgrade
systemctl enable mongod
