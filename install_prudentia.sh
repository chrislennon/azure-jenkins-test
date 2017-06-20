#!/bin/bash

# OS
sudo apt-get update --yes
sudo apt-get -y upgrade

# Python install
sudo apt-get install -y python3-dev python3-pip python-dev build-essential 

# Prudentia dependancy install
sudo apt-get install -y libffi-dev libssl-dev

# Install prudentia under the jenkins user
sudo -H -u jenkins bash -c 'pip3 install prudentia' # This should probably be part of each jenkins job as a virtualenv 
