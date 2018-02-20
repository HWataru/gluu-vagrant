#!/bin/sh
hostnamectl set-hostname $hostname
yum -y install -y wget net-tools
echo "session    required     pam_limits.so" >> /etc/pam.d/login
wget https://repo.gluu.org/centos/Gluu-centos7.repo -O /etc/yum.repos.d/Gluu.repo
wget https://repo.gluu.org/centos/RPM-GPG-KEY-GLUU -O /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
yum clean all
yum install -y gluu-server-$version
systemctl restart network.service
cp -p /vagrant/tmp/setup.properties /opt/gluu-server-$version/install/community-edition-setup/
/sbin/gluu-serverd-$version enable
/sbin/gluu-serverd-$version start