define lamp-hosting-websites::adduser ( $userName = $title ) {

  
    ## Should make better names for these varibles
    ## have to test if is array because if site is "default" then it won't be and will fail on join

      user { "${userName}":
        ensure     => present,
        comment    => "User Account for the web site $site",
        groups     => "webhosting",
        managehome => "yes",
        shell      => "/bin/fase",
      }

      file { "${userName}":
        path   => "/home/${userName}",
        ensure => "directory",
        owner  => "${userName}",
        group  => "${userName}",
      }
        
}


