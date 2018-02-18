# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# load config.yaml
conf = YAML::load(File.read("#{File.dirname(__FILE__)}/config.yaml"))

## make properies file
props = ['# Gluu properties file']
conf['prop'].each do |v|
    props << v[0] + "=" + v[1].to_s
end
File.open("tmp/setup.properties", mode = "w"){|f|
    f.write(props.join("\n"))
}
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

  config.vm.network "private_network", ip: conf["prop"]["ip"], virtualbox__intnet: "private"
  config.vm.network :forwarded_port, guest: 22, host: 10022, id:"ssh"
  config.vm.network :forwarded_port, guest: 443, host: 443  
  config.vm.synced_folder ".", "/vagrant",type:"virtualbox"

  if Vagrant.has_plugin?("vagrant-proxyconf") && ENV['http_proxy']
    config.proxy.http = ENV['http_proxy']
    config.proxy.https = ENV['https_proxy'] ? ENV['https_proxy'] : ENV['http_proxy']
    config.proxy.no_proxy = "localhost,127.0.0.1,192.168.82.*"
  end

  config.vm.provider "virtualbox" do |vm|
    vm.memory = 2048
  end

  config.vm.provision "shell", env: {"version" => conf["version"], "hostname" => conf["prop"]["hostname"], "ip" => conf["prop"]["ip"]} , inline: <<-SHELL
    echo "vagrant soft nofile 65536" >> /etc/security/limits.conf
    echo "vagrant hard nofile 131072" >> /etc/security/limits.conf
    echo "65535" > /proc/sys/fs/file-max** 
    sysctl -p 
    hostnamectl set-hostname $hostname
    systemctl restart network.service
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
    /sbin/gluu-serverd-$version login
    cd /install/community-edition-setup
    -e -n -f ./setup.properties
  SHELL
end
