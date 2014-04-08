maintainer        "Amazon Web Services"
license           "Apache 2.0"
description       "Installs and configures MySQL"
version           "0.1"
recipe            "mysql::client", "Installs MySQL"
recipe            "mysql::server", "Installs MySQL"
recipe            "mysql::backup", "Installs MySQL backup scripts"

['centos','redhat','fedora','amazon','debian','ubuntu'].each do |os|
  supports os
end

%w(ubuntu debian).each do |platform|
  supports platform
end

attribute "mysql_backup",
  :display_name => "Backup Scripts",
  :description => "Hash of Backup Scripts attributes.",
  :type => "hash"

attribute "mysql_backup/target_directory",
  :display_name => "Target directory",
  :description => "The directory where backups should be placed",
  :default => "/backups"

attribute "mysql_backup/hour",
  :display_name => "Hour",
  :description => "The hour of day (24hr) to run the backup scripts",
  :default => "3"

attribute "mysql_backup/minute",
  :display_name => "Minute",
  :description => "The minute of the hour to run the backup scripts",
  :default => "0"

attribute "mysql_backup/retention_days",
  :display_name => "Retention days",
  :description => "The number of days to store backed up files before deleting them",
  :default => "10"

attribute "mysql_backup/xtrabackup",
  :display_name => "Xtrabakup Source",
  :description => "Source download location for xtrabackup binary install",
  :default => "http://www.percona.com/redir/downloads/XtraBackup/LATEST/binary/Linux/x86_64/percona-xtrabackup-2.1.8-733-Linux-x86_64.tar.gz"
