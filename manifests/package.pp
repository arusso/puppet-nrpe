# == Class: nrpe::package
#
# Install the NRPE package
#
# === Notes:
#
# If xinetd is being used, a Package['nrpe'] will notify
# Service['xinetd::service'], ensuring the nrpe user will exist before xinetd is
# reloaded
#
class nrpe::package {
  include nrpe
  package { 'nrpe': ensure => installed }
  if $nrpe::xinetd_r {
    include xinetd
    # ensure our nrpe user is setup first before we reload xinetd
    Package['nrpe'] ~> Class['xinetd::service']
  }
}
