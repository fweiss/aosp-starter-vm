Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |v|
  	v.memory = 4096
  	v.cpus = 4
  end

  config.vm.provision :chef_solo do |chef|
    chef.arguments = "--chef-license accept"
    chef.add_recipe 'aosp'
  end

end

