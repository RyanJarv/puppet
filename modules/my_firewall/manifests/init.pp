class my_firewall {
  class { ['my_firewall::pre', 'my_firewall::post']: }
  
  Firewall {
    before  => Class['my_firewall::post'],
    require => Class['my_firewall::pre'],
  }

  class { 'firewall': }
}
