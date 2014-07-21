VAGRANTFILE_API_VERSION = "2"
STORM_VERSION = "incubator-storm-0.9.1.0-incubating"
STORM_ARCHIVE = "./#{STORM_VERSION}.zip"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.manage_host = true
  config.hostmanager.enabled = true

  if (!File.file?(STORM_ARCHIVE))
    `wget -N https://github.com/apache/incubator-storm/archive/v0.9.1.0-incubating.zip -O #{STORM_ARCHIVE}`
  end

  config.vm.define "zookeeper" do |zookeeper|
    zookeeper.vm.box = "hashicorp/precise32"
    zookeeper.vm.network "private_network", ip: "192.168.50.3"
    zookeeper.vm.hostname = "zookeeper"
    zookeeper.vm.provision "shell", path: "install-zookeeper.sh"
  end

  config.vm.define "nimbus" do |nimbus|
    nimbus.vm.box = "hashicorp/precise32"
    nimbus.vm.network "private_network", ip: "192.168.50.4"
    nimbus.vm.hostname = "nimbus"

    nimbus.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "nimbus"
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "ui"
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "drpc"
    nimbus.vm.provision "shell", path: "start-supervisord.sh"
  end

  config.vm.define "supervisor1" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.5"
    supervisor.vm.hostname = "supervisor1"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
  end

  config.vm.define "supervisor2" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.6"
    supervisor.vm.hostname = "supervisor2"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
  end

  config.vm.define "supervisor3" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.7"
    supervisor.vm.hostname = "supervisor3"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
  end
end
