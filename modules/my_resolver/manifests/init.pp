class my_resolver {

  firewall { '400 DNS out':
    ensure => present,
    port   => 53,
    action => accept,
    chain  => 'OUTPUT',
    } 

  ## ubntu uses the resolveconf service instead of /etc/resolv.conf directly
  ## probably should check for the resolv package instead actually
  if $lsbdistid == "Ubuntu" {
    service { "resolvconf":
      ensure => running,
    }
    File['resolv.conf'] ~> Service["resolvconf"]
  }

  ## hiera supplies alternative config_file for ubuntu systems
  ## all other data is supplied from hiera
  include resolver
}
