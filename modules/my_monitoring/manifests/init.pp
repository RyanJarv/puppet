class my_monitoring {
  if "$lsbdistid" == "Ubuntu" {
    include my_monitoring::linux
  }
  class { 'my_monitoring::my_snmp': }
}
