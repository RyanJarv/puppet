class my_dns {
  include dns::server
  firewall { '200 allow dns in':
    port   => 53,
    proto  => 'udp',
    action => accept,
    chain  => 'INPUT',
  }
  ## magic spaceships collect all ta resources
  ## All lamp dns records are exported in modules/lamp-hosting-websites/manifests/php-vhost.pp

  $test = hiera('dns::zone::soa', 'none')
  notify { "$test": }
  dns::zone {"forest.net":
    soa         => "ns1.puppet.local",
    soa_email   => "admin.puppet.local",
    nameservers => ["ns1.puppet.local", "ns2.puppet.local"],
  }
  Dns::Zone <<| |>>
  Dns::Record::A <<| |>>

  File <<| |>>
}

