# == Class: nrpe::service
#
# Manages the NRPE service.
#
class nrpe::service (
  $xinetd = 'UNSET'
) {
  case $xinetd {
    true: {
      $ensure_r = stopped
      $enable_r = false
    }
    false: {
      $ensure_r = running
      $enable_r = true
    }

    'UNSET': {
      fail('xinetd parameter left unset')
    }

    default: {
      fail('invalid value for xinetd passed')
    }
  }

  service { 'nrped':
    ensure => $ensure_r,
    enable => $enable_r,
  }
}
