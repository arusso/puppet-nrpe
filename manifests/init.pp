class nrpe (
  $allowed_hosts = [ '127.0.0.1' ],
  $use_xinetd = false
) {
  include nrpe::package, nrpe::service, nrpe::config
}
