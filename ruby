#!/bin/bash
set -e

# Install ruby
apt update -y
apt upgrade -y
apt install ruby-full -y
apt update -y
apt upgrade -y
sudo apt-get install libmagickwand-dev -y
