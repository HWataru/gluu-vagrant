#!/bin/sh
yum -y install -y wget net-tools
wget https://repo.gluu.org/centos/Gluu-centos7.repo -O /etc/yum.repos.d/Gluu.repo
wget https://repo.gluu.org/centos/RPM-GPG-KEY-GLUU -O /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
yum clean all
yum install -y gluu-server-$version
systemctl restart network.service
/sbin/gluu-serverd-$version enable
/sbin/gluu-serverd-$version start