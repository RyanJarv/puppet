class profiles::base {
  include my_firewall
  include my_networking
  include my_resolver
  ## all users go in global.yaml
  users { sysadmins: }
}

class profiles::linux {
  class { "my_ssh": }
  class { "my_monitoring": }
  class { "sudo": }
}

class profiles::lamp {
  class { "mod-fastcgi_php5-fpm": }
  class { "::mysql::server": }
  class { "php": }
  class { "lamp-hosting-websites": }
  class { "apache": }
  class { "my_vsftpd": }
  ## Memcached isn't doing anything right now, need to research it.
  class { "memcached":
    max_memory => '30%'
  }
}

class profiles::dns {
  class { "my_dns": }
  }

class profiles::bacula {
  class { "mysql::server": }
}
