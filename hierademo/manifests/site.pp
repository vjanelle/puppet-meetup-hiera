import 'infrastructure.pp'

node 'default' {
}

# node 'app' {
#  # include openssh
#}

#node 'app' {
#  class { 'openssh::enc':
#    port        => 22,
#    allow_users => ['root']
#  }
#}
