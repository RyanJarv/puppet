define lamp-hosting-websites::php-vhost {
  apache::vhost { 'default':
    docroot     => '/var/www/${site}',
    server_name => false,
    template    => 'lamp-hosting-websites/virtualhost/php-vhost.conf.erb',
  }
