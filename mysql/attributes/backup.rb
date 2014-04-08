#
# Cookbook Name:: backup_scripts
# Attribute File:: default
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

default[:mysql_backup][:target_directory] = "/backups"
default[:mysql_backup][:hour] = "3"
default[:mysql_backup][:minute] = "0"
default[:mysql_backup][:retention_days] = 10
default[:mysql_backup][:xtrabackup] = "http://www.percona.com/redir/downloads/XtraBackup/LATEST/binary/Linux/x86_64/percona-xtrabackup-2.1.8-733-Linux-x86_64.tar.gz"
default[:mysql_backup][:user] = 'root'
default[:mysql_backup][:password] = nil
