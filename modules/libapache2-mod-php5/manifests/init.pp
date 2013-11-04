class mod-fastcg_php5-fpm {
    package { 'libapache2-mod-php5':
      name   => 'libapache2-mod-php5',
      ensure => 'present',
    }
    apache::module { 'php5': }
    apache::module { 'actions': }
}
