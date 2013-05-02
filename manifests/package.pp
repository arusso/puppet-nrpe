class nrpe::package {
  include nrpe
  package { 'nrpe': ensure => installed }
  if $nrpe::xinetd_r { include xinetd }
}
