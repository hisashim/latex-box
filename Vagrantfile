# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = ENV['BASE']

  Dir.glob("shell/*").sort.each do |sh|
    config.vm.provision :shell, path: sh
  end
end
