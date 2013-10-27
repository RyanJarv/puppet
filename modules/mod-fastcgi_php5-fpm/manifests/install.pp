class mod-fastcgi_php5-fpm::install {
  package { 'libapache2-mod-fastcgi':
    name   => 'libapache2-mod-fastcgi',
    ensure => 'present',
  }
  package { 'php5-fpm':
    name   => 'php5-fpm',
    ensure => 'present',
  }
}
