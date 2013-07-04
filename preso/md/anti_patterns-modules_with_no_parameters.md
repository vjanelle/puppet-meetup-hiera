## Modules with no parameters

* Requires editing for every change
  * Usually some sort of selector, case, if constructs, etc
* Should be migrated to parameters asap
* Might also rely on global variables

```puppet
# Openssh module with no parameters
class openssh {
  $port = 22
  $protocol = '2'

  $allow_users = ['random','root']
} 
```

<aside class="notes">
If you've got some exceptionally old puppet code, you might seen something similar.
<p />
<b>!! Demo the openssh/manifests/init.pp script, tinker with it !!</b>
<p />
[Walkthrough openssh/manifests/init.pp, demonstrate where $allow_users is, and the template]<br />
[Uncomment node 'app' from site.pp]<br />
[Demo on "app" the manifest being applied]<br />
[Comment 'node' app with 'include openssh']<br />
[Demo extended openssh::enc version with params, but discuss $port without default variable, causing you to need to specify resource-like, cluttering manifest]<br />
<ul><li>ENC would allow you to specify this parameter</li>
<li>Hiera databindings would allow you to use include-like resources, which will query hiera in a structured fashion for variables.</li>
</ul>
</aside>



## Other Assumptions

* Node-specific variables (or inherited node data)
  * Giant list of variables containing the structure of your deployments
* Decisions made in templates
  * if fqdn == "…"
  * Global variables in site.pp, ENC
  
<aside class="notes">
You may have other kinds of data in your catalog/manifests/modules - say an inherited node, a giant list of global variables, using node-level variables, etc.
<p>
Using puppet itself to store data is sort-of ok while protyping - having to flip back and forth between YAML and Puppet can be taxing.
<p />
Overall, modules should be unique pieces of work that get the smallest amount of work done
<p />For example, configure mysql - but not say configure DRBD, heartbeat, etc.  While puppet lacks support for a language feature of a 'role' or 'profile', it is acceptable to have a module called as such that implements a system, such as "role::ha_mysql" that configures mysql, configures drbd, configures heartbeat and reports the sucess of configuration back to puppet.
</aside>



## Overriding data
```puppet
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
```
<aside class="notes">
<p/ >
Some sites have used puppet itself to store data.  This mostly works out, but tends to lead to situations where you're making changes about data, or duplicating environments..
<p />
Another issue with doing this - can anyone spot the error?
</aside>



### Pop quiz
```puppet
class ntp (
  $ntpservers = $ntpservers # Node scope lookup
) {
  # notice("${ntpservers} on ${::fqdn}")
}

node some_inherited_node {
  $ntpservers = '127.0.0.1'
  include ntp
}

node 'default' inherits some_inherited_node {
  $ntpservers = '127.0.0.2'

  notice ("\$ntp::servers is ${ntp::ntpservers}")
  notice ("\$ntpservers is ${ntpservers}")
}
```
<aside class="notes">
What will this output?
<p /><b>!! Wait for response !!</b>
</aside>



### Not what you'd probably want
```
Notice: Scope(Node[default]): $ntp::servers is 127.0.0.1
Notice: Scope(Node[default]): $ntpservers is 127.0.0.2
```

# :(




## Solution with Hiera
```yaml
---
:backends:
  - yaml
:yaml:
  :datadir: /etc/puppet/hieradata
:hierarchy:
  - %{::fqdn} # Fact
  - %{::environment} # Master-set variable
  - %{custom_location} # Node-level variable, $custom_location
  - common # Generic shared resources
```
<aside class="notes">
Sample hiera configuration file - yours will most likely be more complicated.
<ul>
<li>fqdn - a facter fact.  Provided by puppet when calling hiera</li>
<li>environment - master-set variable, with puppet 3 the agent may request it, but an ENC can override it.</li>
<li>$custom_location - A user defined variable contained in the local scope when puppet requests data from hiera.  There's suggested practices for this, usually only acceptable if set in the node scope.</li>
</ul>
</aside>



## Testing on the command line

```shell
[vagrant@ etc]$ hiera ntp::ntpservers
10.0.0.1
[vagrant@ etc]$ hiera ntp::ntpservers ::clientcert=puppet.localdomain
192.168.0.1
```

```yaml
common.yaml
ntp::ntpservers: '10.0.0.1'
```

* puppet.localdomain.yaml

```yaml
ntp::ntpservers: '192.168.0.1'
```
<aside class="notes">
You can also use hiera on the command line to lookup variables - useful for debugging.  
<p />The basic command line options are the key you want to look up, and any variables you wish to pass to hiera.
<p />
There are other options of course in puppet - merging lookups, priorities, even overriding the hierachy. 
</aside>