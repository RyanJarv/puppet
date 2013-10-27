class profiles::base {
  include networking
  include users
}

class profiles::lamp {
  notify { "running profile lamp right now":}
  class { "apache":}
  class { "mod-fastcgi_php5-fpm":}
  class { "::mysql::server": }
  class { "php": }
  class { "lamp-hosting-websites": }
}

class profiles::linux {
  notify { "running profile linux right now":}
  class { "ssh": }
}
