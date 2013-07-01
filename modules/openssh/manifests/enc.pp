# Openssh module with no parameters
class openssh::enc (
  $port,
  $protocol = '2',
  $allow_users = ['random, root']
) {

  package { ['openssh-server','openssh-clients']:
    ensure => installed,
  }

  file { '/etc/ssh/sshd_config':
    content => template('openssh/sshd_config'),
    require => Package['openssh-server'],
  }

  service { 'sshd':
    ensure    => running,
    subscribe => File['/etc/ssh/sshd_config'],
  }

}
