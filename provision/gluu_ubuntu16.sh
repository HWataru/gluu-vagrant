#!/bin/sh
hostnamectl set-hostname $hostname
echo "deb https://repo.gluu.org/ubuntu/ xenial main" > /etc/apt/sources.list.d/gluu-repo.list
curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add -
apt-get update
apt-get install -y gluu-server-$version
service gluu-server-$version start