class my_monitoring::my_snmp {
  #hiera for config values
  include snmp

  $monitoringIP = hiera('monitoringIP')

  firewall { '400 allow SNMP pulls for monitoring':
    port   => 161,
    proto  => udp,
    source => "$monitoringIP",
    action => accept,
    chain  => 'INPUT',
  }
  firewall { '400 allow SNMP pulls from puppet master':
    port   => 161,
    proto  => udp,
    source => "$monitoringIP",
    action => accept,
    chain  => 'INPUT',
  }
}
