class my_networking {

  ## Setup loopback then loop through IPs hash in hiera
  ## IPs hash will look like this:
  ##  IPs:
  ##    <any name>:
  ##      eth: <adapter>
  ##      ip: DHCP
  ##    backnet:
  ##      eth: eth1
  ##      ip: 192.168.56.111
  ##      netmask 255.255.255.0
  ##

  network_config { 'lo':
    ensure => 'present',
    family => 'inet',
    method => 'loopback',
    onboot => 'true',
  }
  ##  my_network_config is wrapper for network::network_config from
  ##  puppet forge 
  $ipNames        = keys(hiera("IPs"))
  if is_hash($ipNames['publicIP']) {
    ::$my_PublicIP = $ipNames['publicIP']['ip']
  }
  if is_hash($ipNames['backnet']) {
    ::$my_BacknetIP = $ipNames['publicIP']['ip']
  }
  if is_hash($ipNames['backnet2']) {
    ::$my_BacknetIP2 = $ipNames['publicIP']['ip']
  }

  my_networking::my_network_config { $ipNames: }

  ## Manage hosts through hiera
  $hosts = hiera('hosts')
  file { "/etc/hosts":
    ensure  => file,
    mode    => 644,
    content => template('my_networking/hosts.erb')
  }

  ## Get domain and fqdn
  $domain_split = split($fqdn, '[.]')
  $domain_splitSize = size($domain_split) - 1  ## array starts at zero
  $domainPosition = $domain_splitSize - 1
  $domain_array = values_at($domain_split, [ "$domainPosition", "$domain_splitSize" ])
  $domain = join($domain_array, '.')

  $my_fqdn = "${fqdn}."
  @@dns::record::a { "$fqdn":
    host => "$my_fqdn",
    zone => "$domain",
    #fixme
    ## need some way of determining what the ip for this site should be.
    data => ["$ipaddress_eth1"],
  }
}
