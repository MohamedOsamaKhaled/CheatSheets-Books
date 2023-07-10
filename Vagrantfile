# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Set the base box image
  config.vm.box = "centos/7"
  
  config.vm.provider "virtualbox" do |name|
   name.name = "OC_Dev"
  end

  # Set the hostname of the VM
  config.vm.hostname = "openshift.local"

  # Set the IP address of the VM
  config.vm.network "public_network"

  # Set the provider
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = "2"
  end

  # Run shell scripts to provision the VM
  config.vm.provision "shell", path: "provision.sh"
end