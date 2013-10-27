class libapache2-mod-php5::install {
    package { 'libapache2-mod-php5':
      name   => 'libapache2-mod-php5',
      ensure => 'present',
    }
    apache::module { 'php5': }
}
