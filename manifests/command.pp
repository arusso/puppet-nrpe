define nrpe::command (
  $command = undef
) {
  include nrpe
  case $name {
    /^[a-z][a-z0-9_]+$/: { $name_r = $name }
    default: {
      fail("Nrpe::Check_command[${name}] : Invalid command name")
    }
  }

  case $command {
    undef,'': {
      fail("Nrpe::Check_command[${name}] : Check command must be specified")
    }
    default: {
      $command_r = $command
    }
  }

  file { "${nrpe::nrpe_dot_d_dir}/${name_r}.cfg":
    ensure  => 'file',
    owner   => 'nrpe',
    group   => 'nrpe',
    mode    => '0440',
    content => "command[${name_r}]=${command_r}\n",
    require => Class['nrpe::package'],
  }
}
