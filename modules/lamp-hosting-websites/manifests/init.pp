class lamp-hosting-websites {
  apache::vhost { 'default':
    docroot     => '/var/www/default',
    server_name => false,
    priority    => '',
    template    => 'apache/virtualhost/vhost.conf.erb',
  }
  notify{'hello from lamp-hosting-websites':}
}
