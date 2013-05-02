class nrpe::config {
  $xinetd_disable = $nrpe::xinetd_r ? {
    true    => 'no',
    default => 'yes',
  }

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
      'only_from'      => join($nrpe::allowed_hosts_r, ' '),
    }
  }
}
