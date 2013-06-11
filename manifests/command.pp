# == Class: nrpe::command
#
# NRPE command item.  Resource name is the command name.
#
# === Parameters:
#
# [*command*]
#
# Command to execute for this check
#
define nrpe::command (
  $command = 'UNSET'
) {
  include nrpe

  if $name =~ /^[a-z][a-z0-9_]+$/ {
    $name_r = $name
  } else {
    fail("Nrpe::Check_command[${name}] : Invalid command name")
  }

  if $command == 'UNSET' or $command == '' {
    fail("NRPE::Check_command[${name}] : check command must be specified")
  } else {
    $command_r = $command
  }

  file { "${nrpe::conf_d_r}/${name_r}.cfg":
    ensure  => 'file',
    owner   => 'nrpe',
    group   => 'nrpe',
    mode    => '0440',
    content => "command[${name_r}]=${command_r}\n",
    require => Class['nrpe::package'],
  }
}
