class my_monitoring::linux {


  $monitoringIP = hiera('monitoringIP')

  file {'/usr/local/bin/serverscheck':
    ensure => present,
    mode => 655,
    owner => 'root',
    source => 'puppet:///modules/my_monitoring/serverscheck'
  }->
  file {'/etc/init.d/serverscheck':
    ensure => present,
    mode => 655,
    owner => 'root',
    source => 'puppet:///modules/my_monitoring/initscript'
  }->
  service {'serverscheck':
    ensure => running,
    enable => true,
  }->
  firewall { '410 allow servercheck from monitoring server':
    dport   => 5555,
    proto  => tcp,
    source => "$monitoringIP",
    action => accept,
    chain  => 'INPUT',
  }
}
