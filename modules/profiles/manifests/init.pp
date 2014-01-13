class profiles::base {
  include my_firewall
# include my_networking ## removed module
  include my_resolver
  ## all users go in global.yaml
  #
  users { sysadmins: }
}

class profiles::master {
  include my_puppet
  #include my_dhcp
  ## DHCP settings handled through hiera in enviorment
}

class profiles::linux {
  class { "my_ssh": }
  class { "my_monitoring": }
  class { "sudo": }
  notify { "Hello from linux": }
}

class profiles::virtualmin {
  class { "my_virtualmin": }
}

## Contains lamp specific details for hosts with virtualmin
class profiles::lamp {
  include lamp
  ## Virtualmin Users are going in /home so we need to but our users somewhere else. If we can change where virtualmin puts it's
  ## users it might be better to change that. admin home directorys are specified in hiera.
  file { "/usr/local/home":
    ensure => directory,
  }
}

## Old lamp, this won't work with virtualmin without ALOT of work
## 
#class profiles::lamp {
#  class { "mod-fastcgi_php5-fpm": }
#  class { "::mysql::server": }
#  class { "php": }
#  class { "lamp-hosting-websites": }
#  class { "apache": }
#  class { "my_vsftpd": }
#  ## Memcached isn't doing anything right now, need to research it.
#  class { "memcached":
#    max_memory => '30%'
#  }
#}

class profiles::dns {
  class { "my_dns": }
  }

class profiles::bacula {
  class { "mysql::server": }
}
