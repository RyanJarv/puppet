define lamp-hosting-websites::removeuser ( $site = $title ) {
  if  ! ($site in ['nothing', '']) {
    ####
    #### Create user name from site name, strip off tld, capitalize first letter eache part of
    #### the domain and remove the  '.' (can't have a dot in the domain name, caps makes it more 
    #### readable
    ####

    $site_array = split( "${site}", '[.]')
    $site_arrayCap = capitalize($site_array)
    $site_arrayJoined = join($site_arrayCap, "")

    $userName = $site_arrayJoined
    notice("$userName")

    user { "remove_${userName}":
      name       => "${userName}",
      ensure     => "absent",
      managehome => "yes",
    }
    notify { "Trying to remove the user name: ${userName}":}

    file { "removeFile_${userName}":
      path   => "/home/${userName}",
      ensure => "absent",
      owner  => "${userName}",
      group  => "${userName}",
      force  => true,
    }
  }
}


