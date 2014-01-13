class my_ssh ( $sshIPs )
{
  firewall {'400 allow local ssh access':
    ensure => present,
    dport   => 22,
    source => $sshIPs, #In hiera
    proto  => tcp,
    action => accept,
    chain  => INPUT,
  }

  class { "ssh": }
}
