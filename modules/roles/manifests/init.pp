class roles {
  include profiles::base
}

class roles::master inherits roles {
  include profiles::master
  include profiles::linux
}
 
class roles::master::test inherits roles::master {
}

class roles::virtualmin inherits roles {
  include profiles::virtualmin
}

class roles::lamp inherits roles {
  include profiles::virtualmin
  include profiles::linux
  include profiles::lamp
}

class roles::lamp::test inherits roles::lamp {
}



##
## Old lamp set up this isn't gonna work with virtualmin without
## ALOT of work
##
#class roles::lamp inherits roles {
#    include profiles::lamp
#    include profiles::linux
#  include my_networking
#}
#class roles::linuxDns inherits roles {
#    include profiles::dns
#    include profiles::linux
#}
#class roles::lamp::test inherits roles::lamp {
#}

# Not used
#class roles::bacula inherits roles {
#  #include profiles::bacula
#  include profiles::linux
#}
#
#class roles::nagios inherits roles {
#  #include profiles::nagios
#  include profiles::linux
#}
