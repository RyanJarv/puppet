class roles {
  include profiles::base
}

class roles::lamp inherits roles {
    include profiles::lamp
    include profiles::linux
}

class roles::linuxDns inherits roles {
    include profiles::dns
    include profiles::linux
}


class roles::lamp::test inherits roles::lamp {
}

class roles::bacula inherits roles {
  #include profiles::bacula
  include profiles::linux
}

class roles::nagios inherits roles {
  #include profiles::nagios
  include profiles::linux
}
