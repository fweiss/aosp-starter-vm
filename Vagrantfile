Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.disksize.size = '400GB'

  config.vm.provider "virtualbox" do |v|
  	v.memory = 8192
  	v.cpus = 4
  end

  config.vm.provision :chef_solo do |chef|
    chef.arguments = "--chef-license accept"
    chef.add_recipe 'aosp'
  end

end

