class lamp-virtualmin {
  firewall { '250 allow http':
    port => 80,
    proto => tcp,
    action  => accept,
    chain   =>  'INPUT',
  }
  firewall  { '255 allow https':
    port => 443,
    proto =>  tcp,
    action  =>  accept,
    chain   => 'INPUT',
  }
}
