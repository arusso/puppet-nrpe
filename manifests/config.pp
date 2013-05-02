class nrpe::config {
  $xinetd_enable = $nrpe::xinetd_r ? {
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
      'disable'        => 'no',
      'only_from'      => join($nrpe::allowed_hosts_r, ' '),
    }
  }
}
