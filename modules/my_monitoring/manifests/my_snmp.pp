class my_monitoring::my_snmp {
  #hiera for config values
  include snmp

  $monitoringIP = hiera('monitoringIP')

  firewall { '400 allow SNMP pulls for monitoring':
    dport   => 161,
    proto  => udp,
    source => "$monitoringIP",
    action => accept,
    chain  => 'INPUT',
  }
  firewall { '400 allow SNMP pulls from puppet master':
    dport   => 161,
    proto  => udp,
    source => "$monitoringIP",
    action => accept,
    chain  => 'INPUT',
  }
}
