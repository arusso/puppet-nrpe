# nrpe Module #

This module provides mechanisms to manage your NRPE rules

# Examples #

<pre><code>
  class { 'nrpe':
    allowed_hosts => [ '10.0.0.10', '127.0.0.1' ],
    xinetd        => true,
  }

  nrpe::command { 'check_root_disk':
    command => '/usr/lib64/nagios/plugins/check_disk -w 10% -c 5% /',
  }
</code></pre>
 

License
-------

None

Change Log
----------

* 0.0.1 : Initial Release

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso23/puppet-nrpe/issues/)
