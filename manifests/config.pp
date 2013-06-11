# == Class: nrpe::config
#
# Sets up our NRPE configuration.

# This class is called by the top-level nrpe class, and should not be called
# directly.
#
# === Parameters:
#
# [*allowed_hosts*]
#
# Hosts that are allowed to conenct to nrpe
#
# [*xinetd*]
#
# Whether or not to use nrpe behind xinetd
#
# === Notes:
#
# This class does not fully validate parameters.  It is expected that
# comprehensive validation occurs at the top-level nrpe class, which users
# should be using instead of this class directly.
#
class nrpe::config (
  $xinetd = 'UNSET',
  $allowed_hosts = 'UNSET'
) {
  if $xinetd == 'UNSET' { fail('xinetd parameter left unset!') }
  if $allowed_hosts == 'UNSET' { fail('allowed_hosts parameter left unset!') }

  validate_array( $allowed_hosts )
  validate_bool( $xinetd )

  $xinetd_disable = $xinetd ? {
    true    => 'no',
    default => 'yes',
  }

  # only worry about enabling the nrpe xinetd serivce here. if we want to
  # disable it, we should use the nrpe::config::disable_xinetd class
  if $xinetd {
    xinetd::service_entry { 'nrpe':
      ensure             => 'present',
      options            => {
        'flags'          => 'REUSE',
        'type'           => 'UNLISTED',
        'port'           => '5666',
        'socket_type'    => 'stream',
        'wait'           => 'no',
        'user'           => 'nrpe',
        'group'          => 'nrpe',
        'server'         => '/usr/sbin/nrpe',
        'server_args'    => '-c /etc/nagios/nrpe.cfg --inetd',
        'log_on_failure' => 'USERID',
        'disable'        => $xinetd_disable,
        'only_from'      => join($allowed_hosts, ' '),
      }
    }
  }
}
