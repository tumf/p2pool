# -*- mode: ruby -*-
# 
# berks install --path cookbooks
# vagrant plugin install vagrant-vbguest
Vagrant.configure("2") do |config|
  config.vm.define "box", primary:true do |config|
    config.vm.hostname = "p2pool"
    config.vm.box = "saucy"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"
    config.vm.network :forwarded_port, guest: 80, host: 31080
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "chef-repo/cookbooks"
      chef.data_bags_path = "chef-repo/data_bags"
      chef.environments_path = "chef-repo/environments"
      chef.roles_path = "chef-repo/roles_path"
      chef.run_list =
        [
         "recipe[p2pool]"
        ]
    end
  end
end
