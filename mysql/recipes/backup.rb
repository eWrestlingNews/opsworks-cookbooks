#
# Cookbook Name:: backup_scripts
# Recipe:: mysql
#
# Copyright 2012, Binary Marbles Trond Arve Nordheim
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

src_filename = 'percona-xtrabackup-2.1.8-733-Linux-x86_64.tar.gz'
src_filepath ="#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "#{Chef::Config['file_cache_path']}/percona-xtrabackup"

remote_file src_filepath do
  source node['mysql_backup']['xtrabackup']
  action :create_if_missing
  notifies :run, 'bash[extract_xtrabackup]'
end

directory extract_path do
  action :create
  not_if { File.directory?(extract_path) }
end

bash "extract_xtrabackup" do
  code <<-EOL
  rm -rf #{extract_path}/*
  tar xzvf #{src_filepath} -C #{extract_path} --strip-components=1
  cp #{extract_path}/* /usr/local/bin/
  EOL
end

template "/usr/local/bin/mysql-backup.sh" do
  source "mysql-backup.sh.erb"
  owner "root"
  mode "0700"
end

cron "perform mysql backup" do
  hour node[:mysql_backup][:hour]
  minute node[:mysql_backup][:minute]
  command "/usr/local/bin/mysql-backup.sh >/var/log/mysql-backup.log 2>&1"
end
