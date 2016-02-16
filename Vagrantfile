# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "~/.jenkinshrg", "/home/vagrant/.jenkinshrg"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = "2"
  end
  config.vm.provision "shell", path: "setup/bootstrap.sh", privileged: false
  config.vm.define "master", primary: true do |server|
    server.vm.network "forwarded_port", guest: 8080, host: 8080
    server.vm.network "forwarded_port", guest: 9000, host: 9000
    server.vm.network "private_network", ip: "192.168.33.10", virtualbox__intnet: "intnet0"
    server.vm.provision "shell", path: "setup/master.sh", privileged: false
  end
  config.vm.define "slave", autostart: false do |server|
    server.vm.network "private_network", ip: "192.168.33.11", virtualbox__intnet: "intnet0"
    server.vm.provision "shell", path: "scripts/createnode.sh", args: "slave /home/vagrant http://192.168.33.10:8080", privileged: false
    server.vm.provision "shell", path: "setup/slave.sh", args: "slave http://192.168.33.10:8080", privileged: false
  end
  config.vm.define "debian-wheezy-i386", autostart: false do |server|
    server.vm.box = "boxcutter/debian79-i386"
    server.vm.provision "shell", path: "scripts/createnode.sh", args: "debian-wheezy-i386 /home/vagrant http://jenkinshrg.a01.aist.go.jp", privileged: false
    server.vm.provision "shell", path: "setup/slave.sh", args: "debian-wheezy-i386 http://jenkinshrg.a01.aist.go.jp", privileged: false
  end
  config.vm.define "ubuntu-trusty-amd64", autostart: false do |server|
    server.vm.box = "boxcutter/ubuntu1404"
    server.vm.provision "shell", path: "scripts/createnode.sh", args: "ubuntu-trusty-amd64 /home/vagrant http://jenkinshrg.a01.aist.go.jp", privileged: false
    server.vm.provision "shell", path: "setup/slave.sh", args: "ubuntu-trusty-amd64 http://jenkinshrg.a01.aist.go.jp", privileged: false
  end
  config.vm.define "ubuntu-trusty-64-desktop", autostart: false do |server|
    server.vm.box = "boxcutter/ubuntu1404-desktop"
    server.vm.provision "shell", path: "scripts/createnode.sh", args: "ubuntu-trusty-amd64-desktop /home/vagrant http://jenkinshrg.a01.aist.go.jp", privileged: false
    server.vm.provision "shell", path: "setup/slave.sh", args: "ubuntu-trusty-amd64-desktop http://jenkinshrg.a01.aist.go.jp", privileged: false
  end
end
