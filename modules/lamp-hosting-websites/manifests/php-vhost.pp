define lamp-hosting-websites::php-vhost ( $site = $title, $user ) {

    apache::vhost { "${site}":
      docroot         => "/home/${user}/${site}",
      vhost_name      => $site,
      servername      => $site,
      custom_fragment => template("lamp-hosting-websites/virtualhost/fastcgi.erb"),
    }

    #file { "www-root_${site}":
    #  path    => "/home/${user}/${site}",
    #  ensure  => "directory",
    #}

    file { "www-index_${site}":
      path    => "/home/${user}/${site}/index.php",
      replace => "no",
      ensure  => "present",
      content => template("lamp-hosting-websites/virtualhost/index.html.erb"),
    }

    file { "www-cgi_${site}":
      path    => "/home/${user}/${site}/cgi-bin",
      ensure  => "folder",
  }

  ## Export Resorce collector for including in DNS node
  ## We only want one zone per domain, this could be a subdomain of a site that 
  ## already exists so lets check for that.
  ## We have to use the domain name as the dns record unless we want to edit the puppet
  ## forge module. (trying not to do that)

  ## development

  ## Domain zone needs to look like example.com
  ## but we may be working with subdomain like sub.example.com
  $domain_split = split($site, '[.]')
  $domain_splitSize = size($domain_split) - 1  ## array starts at zero
  $domainPosition = $domain_splitSize - 1
  #notify {"$site :domain positions = $domainPosition and $domain_splitSize":}
  $domain_array = values_at($domain_split, [ "$domainPosition", "$domain_splitSize" ])
  $domain = join($domain_array, '.')


      #notify { "${site}_$domain": }

      if ! defined( Dns::Zone["$domain"]) {
        @@dns::zone { "$domain": 
          soa         => "ns1.puppet.local",
          soa_email   => "admin.puppet.local",
          nameservers => ["ns1.puppet.local", "ns2.puppet.local"],
        }
      }

      ### Dont forget that dot! this is simpler the striping off the $ORIGIN.
      $my_fqdn = "${site}."

      @@dns::record::a { "$site":
        host => "$my_fqdn",
        zone => "$domain",
        #fixme
        ## need some way of determining what the ip for this site should be.
        data => ["$ipaddress_eth1"],
      }
  }
