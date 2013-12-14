class my_virtualmin {
  package {'perl-doc':
    ensure => present,
  }

  firewall { '350 allow virtualmin interface':
    port => 10000,
    proto => tcp,
    action => accept,
    chain => 'INPUT',
  }
}
