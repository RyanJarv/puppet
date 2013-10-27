class roles {
  include profiles::base
}

class roles::lamp inherits roles {
    include profiles::lamp
    include profiles::linux
}

class roles::lamp::test inherits roles::lamp {
  notify { "running test env":}
}
