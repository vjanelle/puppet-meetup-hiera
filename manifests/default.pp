package {'cifs-utils':
  ensure => 'installed'
}

package { 'vim-enhanced':
  ensure => 'installed',
}

package { 'puppet-server':
  ensure => installed,
}

