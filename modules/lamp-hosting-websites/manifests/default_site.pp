class lamp-hosting-websites::default_site {
      $site = "default"
      apache::vhost { "php-vhost_${site}":
        docroot         => "/var/www/${site}",
        servername      => "default",
        custom_fragment => template("lamp-hosting-websites/virtualhost/fastcgi.erb"),
        priority        => '00',
      }

      #file { "www-root_${site}":
      #  path    => "/var/www/${site}",
      #  ensure  => "directory",
      #}

      file { "www-index_${site}":
        path    => "/var/www/${site}/index.php",
        replace => "no",
        ensure  => "present",
        content => template("lamp-hosting-websites/virtualhost/index.html.erb"),
      }

      file { "www-cgi_${site}":
        path    => "/var/www/${site}/cgi-bin",
        ensure  => "folder",
    }
  }
