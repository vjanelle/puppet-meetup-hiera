# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos64_64"
  # config.vm.network :private_network, ip: "172.16.219.10"
  #
  config.vm.define :puppet do |puppet|
    puppet.vm.box = "centos64_64"
    puppet.vm.network :private_network, ip: "172.16.219.10"
    puppet.vm.hostname = "puppet.localdomain"
    puppet.vm.provision :hosts
    puppet.vm.provision :puppet do |puppet|
      puppet.module_path = "modules"
      puppet.options = "-v --summarize"
    end
    # puppet.vm.synced_folder "puppet", "/etc/puppet"
  end

  config.vm.define :app do |app|
    app.vm.box = "centos64_64"
    app.vm.network :private_network, ip: "172.16.219.20"
    app.vm.hostname = "app.localdomain"
    app.vm.provision :hosts
    app.vm.provision :puppet_server do |puppet|
        puppet.puppet_server = 'puppet'
    end
  end

  # config.vm.provision :shell, :path => "bootstrap.sh"
  # config.vm.network :forwarded_port, host: 4567, guest: 80
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "base.pp"
  # end

end
