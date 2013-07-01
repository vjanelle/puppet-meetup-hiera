class ntp (
  $ntpservers = $ntpservers # Node scope lookup
) {
  # notice("${ntpservers} on ${::fqdn}")
}

node default {
  $ntpservers = '127.0.0.1'
  include ntp
}

node 'puppet.localdomain' inherits default {
  $ntpservers = '127.0.0.2'

  notice ("\$ntp::servers is ${ntp::ntpservers}")
  notice ("But I want \$ntpservers to be ${ntpservers}")
}
