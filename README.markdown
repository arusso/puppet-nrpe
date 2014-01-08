# nrpe Module #

This module provides mechanisms to manage your NRPE rules.  Currently only works
when xinetd = true.  Non-xinetd support is coming soon.

# Examples #

    class { 'nrpe':
      allowed_hosts => [ '10.0.0.10', '127.0.0.1' ],
      xinetd        => true,
    }
    
    nrpe::command { 'check_root_disk':
      command => '/usr/lib64/nagios/plugins/check_disk -w 10% -c 5% /',
    }

License
-------

See LICENSE file

Copyright
---------

Copyright &copy; 2014 The Regents of the University of California

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso/puppet-nrpe/issues/)
