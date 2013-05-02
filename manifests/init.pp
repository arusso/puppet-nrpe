class nrpe (
  $allowed_hosts = [ '127.0.0.1' ],
  $xinetd = false
) {
  $xinetd_r = any2bool( $xinetd )

  if ! is_array( $allowed_hosts ) {
    $allowed_hosts_r = split($allowed_hosts, '[:,|;]')
  } else {
    $allowed_hosts_r = $allowed_hosts
  }

  include nrpe::package, nrpe::service, nrpe::config
}
