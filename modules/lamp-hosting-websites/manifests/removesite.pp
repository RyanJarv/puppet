define lamp-hosting-websites::removesite ( $site = $name ) {
  ## If removed_sites equals '' bad shit happens (removes /var/www)
  ## 'nothing' is default if hiera doesn't find anything
  notify {"trying to remove $site":}
  if ! ($site in ['nothing','']) {
    notify {"REMOVING $site":}

    apache::vhost { "php-vhost_${site}":
      docroot     => "/var/www/${site}",
      server_name => $site,
      enable      => false,
    }

    file { "www-root_${site}":
      path   => "/var/www/${site}/",
      ensure => "absent",
      force  => true,
    }

    file { "www-index_${site}":
      path    => "/var/www/${site}/index.php",
      ensure  => "absent",
    }

    file { "www-cgi_${site}":
      path    => "/var/www/${site}/cgi-bin",
      ensure  => "absent",
    }

    lamp-hosting-websites::removeuser { $site: }
  }

}


