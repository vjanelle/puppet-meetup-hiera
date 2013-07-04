## What is Hiera?

* Key/Value lookup for configuration data
  * "ntp::ntpservers"
* Ordered hierachy for structure lookups
  * environment variables, fqdn, clientcert, etc 
* Configurable backends
  * Comes with YAML/JSON backends
  * MySQL, redis, gpg-encrypted backends available
<aside class="notes">
<p />
Usually simple strings for lookups - for puppet autobinding it's the name of the class, and parameter, seperated by double colons
<p />
Puppet &amp; Hiera uses an array of string templates interpolated by data provided by Puppet  to provide a structured "first record wins" (unless you specify otherwise) value determination.  These variables can be master set, facter facts, or node-level variables.
<p />
By default Puppet and Hiera ship with YAML and JSON backends, however there are many community supported backends out there, for things like database servers, zookeeper, puppetdb, etc.
</aside>
