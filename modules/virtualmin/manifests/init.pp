class virtualmin {
  file { "/usr/local/scripts":
    ensure => directory,
  }->
  file { "/usr/local/scripts/virtualmin_install.sh":
    ensure => file,
    content => "puppet:///modules/virtualmin/virutalmin_install.sh",
  }->
  exec { "virtualmin_install_scirpt":
    command => "/usr/local/scripts/virtualmin_install.sh",
    unless => "wheris webmin",
    returns => "0",
    timeout => "600"
  }
}
  

