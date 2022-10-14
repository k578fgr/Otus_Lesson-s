#!/bin/bash
set -e

# Install ruby
apt update -y
apt upgrade -y
apt install ruby-full -y
apt update -y
apt upgrade -y
sudo apt install libmagickwand-dev -y
