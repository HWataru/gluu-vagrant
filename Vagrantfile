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
  config.vm.box = "82p/gluu"
  
  config.vm.network "private_network", ip: conf["prop"]["ip"], virtualbox__intnet: "private"
  config.vm.network :forwarded_port, guest: 22, host: 1022, id:"ssh"
  config.vm.network :forwarded_port, guest: 443, host: 443  
  config.vm.network :forwarded_port, guest: 80, host: 80
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
    hostnamectl set-hostname $hostname
    systemctl restart network.service
    /sbin/gluu-serverd-$version enable
    /sbin/gluu-serverd-$version start
    /sbin/gluu-serverd-$version login
  SHELL
end
