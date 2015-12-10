# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.synced_folder "~", "/share"
  config.vm.synced_folder "~/Documents", "/home/vagrant/Documents"
  config.vm.provision "shell", path: "setup/common.sh", privileged: false
  config.vm.provision "shell", path: "setup/devel.sh", privileged: false
  config.vm.define "master", autostart: true, primary: true do |server|
    server.vm.box = "boxcutter/ubuntu1404"
    server.vm.network "forwarded_port", guest: 8080, host: 8080
    server.vm.network "forwarded_port", guest: 9000, host: 9000
    server.vm.network "private_network", ip: "192.168.33.10", virtualbox__intnet: "intnet0"
    server.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
    server.vm.provision "shell", path: "setup/server.sh", privileged: false
    server.vm.provision "shell", path: "setup/misc.sh", privileged: false
    server.vm.provision "shell", path: "scripts/createnode.sh", args: "slave", privileged: false
    server.vm.provision "shell", path: "scripts/createjob.sh", args: "drcutil https://github.com/jenkinshrg/drcutil.git drcutil ubuntu-trusty-amd64 slave", privileged: false
    server.vm.provision "shell", path: "scripts/createnode.sh", args: "debian-wheezy-i386", privileged: false
    server.vm.provision "shell", path: "scripts/createjob.sh", args: "drcutil-32 https://github.com/jenkinshrg/drcutil.git drcutil debian-wheezy-i386 debian-wheezy-i386", privileged: false
    server.vm.provision "shell", path: "scripts/createnode.sh", args: "ubuntu-trusty-amd64", privileged: false
    server.vm.provision "shell", path: "scripts/createjob.sh", args: "drcutil-64 https://github.com/jenkinshrg/drcutil.git drcutil ubuntu-trusty-amd64 ubuntu-trusty-amd64", privileged: false
    # server.vm.provision "shell", path: "scripts/createnode.sh", args: "ubuntu-trusty-amd64-desktop", privileged: false
    # server.vm.provision "shell", path: "scripts/createjob.sh", args: "drcutil-desktop https://github.com/jenkinshrg/drcutil.git drcutil ubuntu-trusty-amd64 ubuntu-trusty-amd64-desktop periodic", privileged: false
  end
  config.vm.define "slave", autostart: false do |server|
    server.vm.box = "boxcutter/ubuntu1404"
    server.vm.network "private_network", ip: "192.168.33.11", virtualbox__intnet: "intnet0"
    server.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
    server.vm.provision "shell", path: "setup/misc.sh", privileged: false
    server.vm.provision "shell", path: "setup/jnlp.sh", args: "slave http://192.168.33.10:8080", privileged: false
  end
  config.vm.define "debian-wheezy-i386", autostart: false do |server|
    server.vm.box = "boxcutter/debian78-i386"
    server.vm.network "private_network", ip: "192.168.33.12", virtualbox__intnet: "intnet0"
    server.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    server.vm.provision "shell", path: "setup/misc.sh", privileged: false
    server.vm.provision "shell", path: "setup/jnlp.sh", args: "debian-wheezy-i386 http://192.168.33.10:8080", privileged: false
  end
  config.vm.define "ubuntu-trusty-amd64", autostart: false do |server|
    server.vm.box = "boxcutter/ubuntu1404"
    server.vm.network "private_network", ip: "192.168.33.13", virtualbox__intnet: "intnet0"
    server.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    server.vm.provision "shell", path: "setup/misc.sh", privileged: false
    server.vm.provision "shell", path: "setup/jnlp.sh", args: "ubuntu-trusty-amd64 http://192.168.33.10:8080", privileged: false
  end
  # config.vm.define "ubuntu-trusty-64-desktop", autostart: false do |server|
  #   server.vm.box = "boxcutter/ubuntu1404-desktop"
  #   server.vm.network "private_network", ip: "192.168.33.14", virtualbox__intnet: "intnet0"
  #   server.vm.provider "virtualbox" do |vb|
  #     vb.customize ["modifyvm", :id, "--memory", "4096"]
  #     vb.customize ["modifyvm", :id, "--cpus", "2"]
  #     vb.customize ["modifyvm", :id, "--ioapic", "on"]
  #   end
  #   server.vm.provision "shell", path: "setup/misc.sh", privileged: false
  #   server.vm.provision "shell", path: "setup/jnlp.sh", args: "ubuntu-trusty-amd64-desktop http://192.168.33.10:8080", privileged: false
  # end
end
