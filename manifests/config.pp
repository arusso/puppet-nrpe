class nrpe::config {
  if $nrpe::xinetd_r {
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
  } else {
    # use nrpe as a daemon on its own, removing the xinetd config
    fail( 'nrpe running without xinetd is not supported at this time' )
  }
}
