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
</aside>



## Opther Assumptions

* Node-specific variables (or inherited node data)
  * Giant list of variables containing the structure of your deployments
* Decisions made in templates
  * if fqdn == "…"
  * Global variables in site.pp, ENC

<aside class="notes">
You may have other kinds of data in your catalog/manifests/modules - say an inherited node, a giant list of global variables, using node-level variables, etc.
<p>
Using puppet itself to store data is sort-of ok while protyping - having to flip back and forth between YAML and Puppet can be taxing.
</aside>