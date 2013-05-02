class nrpe::package {
  include nrpe
  package { 'nrpe': ensure => installed }
  if $nrpe::xinetd_r {
    include xinetd
    # ensure our nrpe user is setup first before we reload xinetd
    Package['nrpe'] ~> Class['xinetd::service']
  }
}
