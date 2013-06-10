include stdlib

class requirements {
  package {'cifs-utils':
    ensure => 'installed'
  }

  package { 'vim-enhanced':
    ensure => 'installed',
  }

  package { 'puppet-server':
    ensure => installed,
  }
}

class { 'requirements':
  stage => 'setup'
}

Ini_setting {
  ensure  => present,
  path    => '/etc/puppet/puppet.conf',
  section => 'master',
}

ini_setting { 'change master hieraconf':
  setting => 'hiera_config',
  value   => '/vagrant/hierademo/hiera.yaml',
}

ini_setting { 'change master modulepath':
  setting => 'modulepath',
  value   => '/vagrant/modules:/etc/puppet/modules:/usr/share/puppet/modules'
}

