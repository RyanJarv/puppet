class lamp-hosting-websites {
  group {'webhosting':
    ensure => 'present',
  }

  firewall { '100 allow http and https access':
    port   => [80, 443],
    proto  => tcp,
    action => accept,
    chain  => 'INPUT',
  }

  ## We want the default site managed by puppet
  #file {"/etc/apache2/sites-enabled/000-default":
  #  ensure => "absent",
  #  notify => Service["apache2"],
  #}
  ### this will create a site with no server name (default is handled in apahce::vhost)
  #lamp-hosting-websites::addsite{'default': } 
  #include lamp-hosting-websites::default_site


  $current_sites = hiera('current_sites', 'nothing')
  $removed_sites = hiera('removed_sites', 'nothing')


  lamp-hosting-websites::addsite { $current_sites: } 

  lamp-hosting-websites::removesite { $removed_sites: }
}

