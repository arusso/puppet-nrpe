class nrpe::service {
  if ! $nrpe::xinetd_r {
    service { 'nrped':
      ensure => running,
      enable => true,
    }
  }
}
