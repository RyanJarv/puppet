define my_networking::my_network_config ( $ipName = $name ){
  $ip_keys        = hiera("IPs", "DHCP")

  $IP       = $ip_keys["${ipName}"]['ip']
  $netmask  = $ip_keys["${ipName}"]['netmask']
  $eth      = $ip_keys["${ipName}"]['eth']

  

  if $IP in ['DHCP',''] {
    network_config { "${eth}_DHCP":
      name     => "$eth",
      ensure   => 'present',
      family   => 'inet',
      method   => 'dhcp',
      onboot   => 'true',
      #options => {'pre-up' => 'sleep 2'},
    }
  }
  else {

    network_config {"$IP":
      name      => "$eth",
      ensure    => 'present',
      family    => 'inet',
      ipaddress => "$IP",
      method    => 'static',
      netmask   => "$netmask",
      onboot    => 'true',
    }
  }
}
