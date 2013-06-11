# == Class: nrpe
#
#  NRPE class that sets up NRPE service and config on our system
#
# === Parameters:
#
# [*allowed_hosts*]
#
# Array of hosts to allow to connect to NRPE.  Default is [ '127.0.0.1' ]
#
# [*conf_d*]
#
# Override the partial-config directory for NRPE. Default is /etc/nrpe.d.
#
# [*xinetd*]
#
# Should we use xinetd instead of running an NRPE daemon? Default is false.
#
class nrpe (
  $allowed_hosts = [ '127.0.0.1' ],
  $conf_d = 'UNSET',
  $xinetd = false
) {
  include nrpe::params

  $conf_d_r = $conf_d ? {
    'UNSET' => $nrpe::params::conf_d,
    default => $conf_d,
  }
  validate_absolute_path( $conf_d_r )

  $xinetd_r = any2bool( $xinetd )

  # make sure we only have commands we manage in there
  file { $conf_d_r:
    ensure  => directory,
    purge   => true,
    force   => true,
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
  }

  if ! is_array( $allowed_hosts ) {
    $allowed_hosts_r = split($allowed_hosts, '[:,|;]')
  } else {
    # if given an array, we'll join it with commas, then split it
    # like it was one big list of allowed hosts
    $allowed_hosts_r = split( join($allowed_hosts, ','), '[:,|;]')
  }

  include nrpe::package, nrpe::service, nrpe::config
}
