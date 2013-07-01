include stdlib

file {'/home/vagrant/.puppet':
  ensure => directory,
  owner  => vagrant,
  group  => vagrant,
}

file { ['/home/vagrant/.puppet/hiera.yaml', '/etc/hiera.yaml']:
  ensure => link,
  target => '/vagrant/hierademo/hiera.yaml',
}

file {'/home/vagrant/demos':
  ensure => link,
  target => '/vagrant/hierademo/demos',
}


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

  service { 'iptables':
    ensure => stopped,
    enable => false,
  }

}

class { 'requirements':
  stage => 'setup'
}

# Configure puppet master up

Ini_setting {
  ensure  => present,
  path    => '/etc/puppet/puppet.conf',
  section => 'master',
  notify  => Service['puppetmaster']
}

file { '/etc/puppet/autosign.conf':
  content => '*.localdomain',
  mode    => '0644',
  notify  => Service['puppetmaster']
}

service { 'puppetmaster':
  ensure    => running,
}

ini_setting { 'change manifestdir':
  setting => 'manifestdir',
  value   => '/vagrant/hierademo/manifests'
}

ini_setting { 'change master hieraconf':
  setting => 'hiera_config',
  value   => '/vagrant/hierademo/hiera.yaml',
}

ini_setting { 'change master modulepath':
  setting => 'modulepath',
  value   => '/vagrant/modules:/etc/puppet/modules:/usr/share/puppet/modules'
}

file { '/etc/puppet/hiera.yaml':
  ensure => link,
  target => '/vagrant/hierademo/hiera.yaml',
}

file { '/etc/puppet/hieradata/':
  ensure => link,
  target => '/vagrant/hierademo/hieradata',
}

