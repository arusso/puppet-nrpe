# == Class: nrpe::package
#
# Install the NRPE package
#
# === Notes:
#
# If xinetd is being used, a Package['nrpe'] will notify
# Class['xinetd::service'], ensuring the nrpe user will exist before xinetd is
# reloaded
#
class nrpe::package (
  $xinetd = 'UNSET'
) {
  include nrpe

  if $xinetd == 'UNSET' { fail('xinetd parameter left unset!') }
  validate_bool( $xinetd )

  package { 'nrpe': ensure => installed }
  if $xinetd {
    include xinetd
    # ensure our nrpe user is setup first before we reload xinetd
    Package['nrpe'] ~> Class['xinetd::service']
  }
}
