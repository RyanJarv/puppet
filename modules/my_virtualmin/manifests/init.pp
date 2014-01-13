class my_virtualmin { 

  ## This should be done in hiera
  #notify { "$environment":}
  if $environment == "test" {
    $backup_options = "bind"
    $backup_device  = "/vagrant/virtualmin_backups/${fqdn}"
    $backup_fstype  = "none"
    $home_options   = "bind"
    $home_device    = "/vagrant/home_folders/${fqdn}"
    $home_fstype    = "none"
  }
  else {
    $options = "nosuid"
    $device = "NFS_san_goes_here"
    $fstype = "nfs"
  }
 
  file { 'file_/virtualmin_backups':
    name    => '/virtualmin_backups',
    ensure  => 'directory',
    mode    => '750',
  }->
  mount { "home_folders":
    name => "/home",
    ensure => "mounted",
    options => "${home_options}",
    fstype => "${home_fstype}",
    device => "${home_device}",
  }->
  mount { "virtualmin_backups":
    name => "/virtualmin_backups",
    ensure => "mounted",
    options => "${backup_options}",
    fstype => "${backup_fstype}",
    device => "${backup_device}",
  }->
  ## This script is modified so that it resotores all
  ## backups in the /virtualmin_backups after it's done
  ## installing
  file { "/usr/local/scripts":
    ensure => directory,
  }->
  file { "/usr/local/scripts/virtualmin-install.sh":
    ensure  => file,
    mode    => 755, 
    source  => "puppet:///modules/my_virtualmin/virtualmin-install.sh", 
  }-> 
  exec { "virtualmin-install_script":
    command => "/usr/local/scripts/virtualmin-install.sh",
    creates => "/etc/virtualmin-license",
    returns => "0",
    timeout => "600"
  }->
  file { "/usr/local/scripts/virtualmin-restore.sh":
    ensure  => file,
    mode    => 755,
    source  => "puppet:///modules/my_virtualmin/virtualmin-restore.sh", 
  }-> 
  exec { "/usr/local/scripts/virtualmin-restore.sh":
    command   => "/usr/local/scripts/virtualmin-restore.sh",
    unless    => "/usr/bin/virtualmin --help && [ $(/usr/bin/virtualmin list-domains --name-only|/usr/bin/wc -w) -ne 0 ]",
    returns => "0",
    timeout => "600"
  }->
  service { "webmin":
    enable  => true,
    ensure  => running,
  }
  package {'perl-doc':
    ensure => present,
  }
  firewall { '350 allow virtualmin interface':
    dport => 10000,
    proto => tcp,
    action => accept,
    chain => 'INPUT',
  }
  firewall { "360 allow virtualmin":
    dport   => 20000,
    proto   => tcp,
    action  => accept,
    chain   => 'INPUT',
  }
}
