# -*- mode: ruby -*-
# vi: set ft=ruby :vagrant plugin install vagrant-reload

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
  
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "2", "--ioapic", "on"]
  end

  gluuEnv = {"version" => conf["version"], "hostname" => conf["prop"]["hostname"], "ip" => conf["prop"]["ip"]}

  config.vm.network "private_network", ip: gluuEnv["ip"], virtualbox__intnet: "private"
  config.vm.network :forwarded_port, guest: 22, host: 1022, id:"ssh"
  config.vm.network :forwarded_port, guest: 443, host: 443  
  config.vm.network :forwarded_port, guest: 80, host: 80


  # common settings
  config.vm.provision "shell", env: gluuEnv, :path => "./provision/common_setup.sh", :privileged => true
  # install Gluu server
  if config.vm.box.include?("bento/ubuntu-16.04")
    config.vm.provision "shell", env: gluuEnv, :path => "./provision/gluu_ubuntu16.sh", :privileged => true
  elsif config.vm.box.include?("centos/7")
    config.vm.provision "shell", env: gluuEnv, :path => "./provision/gluu_centos7.sh", :privileged => true
  else
    raise "not supported image... This Vagrantfile support centos/7 and bento/ubuntu-16.04"
  end
  # setup Gluu Server
  config.vm.provision "shell", env: gluuEnv, :path => "./provision/setup_gluu.sh", :privileged => true
end
