VAGRANTFILE_API_VERSION = "2"
STORM_VERSION = "apache-storm-0.9.2-incubating"
STORM_ARCHIVE = "./#{STORM_VERSION}.zip"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.manage_host = true
  config.hostmanager.enabled = true

  if (!File.file?(STORM_ARCHIVE))
    `wget -N http://ftp.piotrkosoft.net/pub/mirrors/ftp.apache.org/incubator/storm/apache-storm-0.9.2-incubating/apache-storm-0.9.2-incubating.zip -O #{STORM_ARCHIVE}`
  end

  config.vm.define "zookeeper" do |zookeeper|
    zookeeper.vm.box = "hashicorp/precise32"
    zookeeper.vm.network "private_network", ip: "192.168.50.3"
    zookeeper.vm.hostname = "zookeeper"
    zookeeper.hostmanager.aliases = "n2"
    zookeeper.vm.provision "shell", path: "install-zookeeper.sh"
  end

  config.vm.define "nimbus" do |nimbus|
    nimbus.vm.box = "hashicorp/precise32"
    nimbus.vm.network "private_network", ip: "192.168.50.4"
    nimbus.vm.hostname = "nimbus"
    nimbus.hostmanager.aliases = "n1"

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
    supervisor.hostmanager.aliases = "n4"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
  end

  config.vm.define "supervisor2" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.6"
    supervisor.vm.hostname = "supervisor2"
    supervisor.hostmanager.aliases = "n5"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
  end

  config.vm.define "supervisor3" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.7"
    supervisor.vm.hostname = "supervisor3"
    supervisor.hostmanager.aliases = "n3"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
  end
end
