# -*- mode: ruby -*-
# vi: set ft=ruby :

require "rbconfig"
require "fileutils"

VAGRANTFILE_API_VERSION = "2"

# Customize
PROJECT = "blog"
ANSIBLE_PATH = "config/provisioning/"
ANSIBLE_VARS = {
  app_path: "/home/vagrant/app",
  ruby_version: "2.1.2"
  # Other variables specific to playbook
}

# http://stackoverflow.com/a/5471032/128703
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable? exe
    }
  end
  return nil
end

def windows?
  RbConfig::CONFIG['host_os'] =~ /mswin|win32|dos|mingw|cygwin/i
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = PROJECT
  config.vm.box = "ubuntu/trusty32"
  config.vm.network "private_network", type: "dhcp"
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  sync_opts = { type: windows? ? nil : "nfs" }
  config.vm.synced_folder ".", "/home/vagrant/app", sync_opts
  config.vm.synced_folder ANSIBLE_PATH, "/home/vagrant/provisioning", sync_opts

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    # vb.gui = true

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  # Use ansible provisioner provided by vagrant if ansible-playbook is available locally
  if which("ansible-playbook")
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "#{ANSIBLE_PATH}/app.yml"
      ansible.limit = "app"
      ansible.groups = {
        "app" => ["default"]
      }
      ansible.tags = ENV["TAGS"].split(",") if ENV["TAGS"]
      ansible.extra_vars = ANSIBLE_VARS
    end

  # Fall back to running ansible-playbook in box
  else
    $ansible = <<-SCRIPT
      if ! command -v ansible-playbook >/dev/null 2>&1; then
        apt-get install -y python-software-properties
        add-apt-repository -y ppa:rquillo/ansible
        apt-get update
        apt-get install -y ansible
      else
        ansible-playbook --version
      fi
    SCRIPT

    $playbook = <<-SCRIPT
      cd ~/provisioning
      ansible-playbook #{PROJECT}.yml \
        --inventory=localhost, \
        --connection=local \
        --extra-vars=" + #{ANSIBLE_VARS.map { |k,v| "#{k}=#{v}" }.join(" ")}"
    SCRIPT

    config.vm.provision "shell", inline: $ansible
    config.vm.provision "shell", inline: $playbook, privileged: false
  end

  if sync_opts[:type] == "rsync"
    config.vm.post_up_message = "Run 'vagrant rsync-auto' to sync folders"
  end
end