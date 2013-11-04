class my_vsftpd {
  class { "vsftpd": }

  file {'/usr/local/ssl/':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => 750,
  }->
  file {'/usr/local/ssl/vsftpd.pem':
    ensure => file,
    mode   => 550,
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/my_vsftpd/vsftpd.pem",
  }->
  file {'/usr/local/ssl/vsftpd.key':
    ensure => file,
    mode   => 550,
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/my_vsftpd/vsftpd.key",
  }->
  file {'/usr/share/empty':
    ensure  => directory,
    mode    => 444,
    owner  => 'root',
    group  => 'root',
    recurse => true,
    purge   => true,
  }->
  firewall { '150 allow ftp/ftps access':
    port   => 21,
    proto  => tcp,
    action => accept,
    chain  => 'INPUT',
  }->
  concat{'/etc/vsftpd.user_list':
    owner  => 'root',
    group  => 'root',
    mode   => 644,
  }-> Class['vsftpd']

  concat::fragment{"/etc/vsftpd.user_list":
    target  => '/etc/vsftpd.user_list',
    content => "root",
    order   => 01,
  }
  Concat::Fragment <<| tag == 'admin' |>>

}
