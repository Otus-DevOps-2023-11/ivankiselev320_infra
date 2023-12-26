#!/bin/bash

apt-get update
apt install -y mongodb
systemctl start mongodb
systemctl enable mongodb
systemctl status mongodb
