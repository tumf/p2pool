#
# Cookbook Name:: p2pool
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#include_recipe "apt"

group 'p2pool' do
  group_name 'p2pool'
  gid        10420
  action     [:create]
end

user 'p2pool' do
  comment  'p2pool'
  uid      10420
  group    'p2pool'
  home     '/p2pool'
  shell    '/bin/false'
  password nil
  supports :manage_home => true
  action   [:create, :manage]
end


%w(python-zope.interface python-twisted python-twisted-web).each do |name|
  apt_package name do
    action :install
  end
end


# bitcond for p2pool
%w(bitcoind daemontools daemontools-run).each do |name|
  apt_package name do
    action :install
  end
end

## start svscan
execute "initctl start svscan" do
  only_if "initctl status svscan | grep stop"
  retries 30
end

directory "/p2pool/service/bitcoind/log" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

template "/p2pool/service/bitcoind/run" do
  source "bitcoind-run.erb"
  mode 0755
  owner "root"
  group "root"
end

template "/p2pool/service/bitcoind/log/run" do
  source "bitcoind-log-run.erb"
  mode 0755
  owner "root"
  group "root"
end

directory "/p2pool/service/bitcoind/log/main" do
  owner "p2pool"
  group "p2pool"
  mode 0755
  action :create
end

directory "/p2pool/.bitcoin" do
  owner "p2pool"
  group "p2pool"
  mode 0755
  action :create
end

template "/p2pool/.bitcoin/bitcoin.conf" do
  source "bitcoin.conf.erb"
  mode 0644
  owner "p2pool"
  group "p2pool"
end

daemontools_service "p2pool-bitcoind" do
  directory "/p2pool/service/bitcoind"
  template false
  action [:enable,:start]
end




#directory "/etc/bitcoin" do
#  owner "root"
#  group "root"
#  mode 0755
#  action :create
#end

#template "/etc/bitcoin/bitcoin.conf" do
#  source "bitcoin.conf.erb"
#  mode 0644
#  owner "root"
#  group "root"
#end

#apt_package "bitcoind" do
#  action :install
#end

#service "twistd" do
#  action :enable
#end

# bitcoind -conf=/etc/bitcoin/bitcoin.conf
# wallets /var/lib/bitcoin
