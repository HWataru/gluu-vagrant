# -*- mode: ruby -*-
# vi: set ft=ruby :
gluu_version="3.1.2"
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos/7"

  config.vm.provision "shell", env: {"version" => gluu_version} , inline: <<-SHELL
    echo "vagrant soft nofile 65536" >> /etc/security/limits.conf
    echo "vagrant hard nofile 131072" >> /etc/security/limits.conf
    echo "65535" > /proc/sys/fs/file-max** 
    sysctl -p 
    yum -y install wget
    echo "session    required     pam_limits.so" >> /etc/pam.d/login
    wget https://repo.gluu.org/centos/Gluu-centos7.repo -O /etc/yum.repos.d/Gluu.repo
    wget https://repo.gluu.org/centos/RPM-GPG-KEY-GLUU -O /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
    yum clean all
    yum install -y gluu-server-$version
    cp -p /vagrant/tmp/setup.properties /opt/gluu-server-$version/install/community-edition-setup/
    /sbin/gluu-serverd-$version enable
    /sbin/gluu-serverd-$version start
  SHELL
end
