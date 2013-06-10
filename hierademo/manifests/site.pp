class ntp (
  $ntpservers
  # $ntpservers = $ntpservers # Node scope lookup
) {
  notify { "${ntpservers} on ${::fqdn}": }
}

node default {
  $ntpservers = '127.0.0.1'
  include ntp
}

node 'puppet.localdomain' inherits default {
  $ntpservers = '127.0.0.2'

  notify {  "But I want \$ntpservers to be ${ntpservers}":
    require => Class['ntp']
  } 
}
