node 'production' {
  $ntpservers = ['127.0.0.1','127.0.0.2']

  $smarthost = '192.168.0.1'

  $dns = ['8.8.8.8', '8.8.4.4']

  $allowed_users = ['random', 'root']
}

node 'staging' {
  $ntpservers = ['127.0.0.3','127.0.0.4']

  $smarthost = '10.0.0.1'

  $dns = ['8.8.4.4','8.8.8.8']

  $allowed_users = ['dev', 'root']
}

node 'dev' {
  $ntpservers = ['127.0.0.6','127.0.0.5']

  $smarthost = '172.16.138.1'

  $dns = [ '127.0.0.1']

  $allowe_users = 'root'
}
