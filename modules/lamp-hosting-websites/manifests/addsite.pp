define lamp-hosting-websites::addsite ( $site = $title ) {
  if  ! ($site in ['nothing', '']) {
    #notify { "$site": }

      ###
      ### Create user name from site name, capitalize first letter eache part of
      ### the domain and remove the  '.' (can't have a dot in the domain name, caps makes it more 
      ### readable
      ###
            $site_array = split( "${site}", '[.]')
            $site_arrayCap = capitalize($site_array)
            if is_array($site_arrayCap){
              $site_arrayJoined = join($site_arrayCap, "")
              $userName = $site_arrayJoined
            }
            else {
              $userName = $site_arrayCap
            }
      


    lamp-hosting-websites::adduser { "${userName}": }

    lamp-hosting-websites::php-vhost { "${site}":
      user => $userName,
    }
  }
}
