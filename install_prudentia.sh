#!/bin/bash

# OS
sudo apt-get update --yes
#sudo apt-get -y upgrade

# Python install
sudo apt-get install -y python-dev python-pip python-dev build-essential 

# Prudentia dependancy install
sudo apt-get install -y libffi-dev libssl-dev

# Upgrade pip to latest
sudo -H -u jenkins bash -c 'pip install --upgrade pip'

# Install prudentia under the jenkins user
sudo -H -u jenkins bash -c 'pip install prudentia' # This should probably be part of each jenkins job as a virtualenv 

# Place the path for pip binaries into $PATH for user

sudo -H -u jenkins bash -c 'echo "export LANG=en_US.UTF-8" > /var/lib/jenkins/.bash.rc'
sudo -H -u jenkins bash -c 'echo "export LANGUAGE=en_US:en" >> /var/lib/jenkins/.bash.rc'
sudo -H -u jenkins bash -c 'echo "export PATH=/var/lib/jenkins/.local/bin:$PATH" >> /var/lib/jenkins/.bash.rc'
sudo -H -u jenkins bash -c 'source /var/lib/jenkins/.bash.rc'