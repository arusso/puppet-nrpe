# == Class: nrpe::service
#
# Manages the NRPE service.
#
class nrpe::service {

  case $nrpe::xinetd_r {
    true: {
      $ensure_r = 'stopped'
      $enable_r = false
    }
    default: {
      $ensure_r = 'running'
      $enable_r = true
    }
  }

  service { 'nrped':
    ensure => $ensure_r,
    enable => $enable_r,
  }
}
