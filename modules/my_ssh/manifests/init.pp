class my_ssh ( $sshIPs )
{
  firewall {'800 allow local ssh access':
    ensure => present,
    port   => 22,
    source => $sshIPs,
    proto  => tcp,
    action => accept,
    chain  => INPUT,
  }

  class { "ssh": }
}
