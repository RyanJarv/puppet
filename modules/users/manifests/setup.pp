define users::setup($hash) {
	if(!defined(User[$name])) {
	    user { $name :
                allowdupe            => $hash[$name]['allowdupe'],
                attribute_membership => $hash[$name]['attribute_membership'],
                attributes           => $hash[$name]['attributes'],
                auth_membership      => $hash[$name]['auth_membership'],
                auths                => $hash[$name]['auths'],
                comment              => $hash[$name]['comment'],
                ensure               => $hash[$name]['ensure'],
                expiry               => $hash[$name]['expiry'],
                gid                  => $hash[$name]['gid'],
                groups               => $hash[$name]['groups'],
                home                 => $hash[$name]['home'],
                ia_load_module       => $hash[$name]['ia_load_module'],
                key_membership       => $hash[$name]['key_membership'],
                keys                 => $hash[$name]['keys'],
                managehome           => $hash[$name]['managehome'],
                membership           => $hash[$name]['membership'],
                password             => $hash[$name]['password'],
                password_max_age     => $hash[$name]['password_max_age'],
                password_min_age     => $hash[$name]['password_min_age'],
                profile_membership   => $hash[$name]['profile_membership'],
                profiles             => $hash[$name]['profiles'],
                project              => $hash[$name]['project'],
                provider             => $hash[$name]['provider'],
                role_membership      => $hash[$name]['role_membership'],
                roles                => $hash[$name]['roles'],
                shell                => $hash[$name]['shell'],
                system               => $hash[$name]['system'],
                uid                  => $hash[$name]['uid'],
	    }
      $tag = $hash[$name]['tag']
      if ( "$tag" == 'admin' ) {
        @@concat::fragment{"/etc/vsftpd.user_list.$name":
          target  => "/etc/vsftpd.user_list",
          content => "\n$name",
          tag     => 'admin',
        }
      }

      $sudoensure = $hash[$name]['sudo_ensure']
      if ("$sudoensure" in ['present', 'absent']) {
      notify {"$name :sudoensure is $sudoensure": }
        sudo::conf { "user_sudoers_${name}":
          ensure          => $hash[$name]['sudo_ensure'],
          priority        => $hash[$name]['sudo_priority'],
          content         => $hash[$name]['sudo_content'],
          #source          => $hash[$name]['sudo_source'],
          #sudo_config_dir      => $hash[$name]['sudo_config_dir'],
        }
      }


	    if($hash[$name]['ssh_authorized_keys']) {
		$_sshkey = $hash[$name]['ssh_authorized_keys']
		if(is_hash($_sshkey)) {
		    $_sshkeys = keys($_sshkey)
		    users::ssh_authorized_keys { $_sshkeys:
          hash => $_sshkey,
          user => $name,
		    }
		} else {
		    notify { "user ssh key data for ${name} must be in hash form": }
		}
	    }
	}
}

