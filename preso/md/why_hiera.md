## Why Hiera?

* Data seperation
  * Keep node/environment/site-specific data out of manifests
  * Reduce special snowflakes, make deviations options
  * Avoid repetition, extracting common data
  * Only store differences between sets
  
<aside class="notes">
<p />
(Repeat out slide)
<p />I'll be showing try to show a few 'anti-patterns' that have been accepted norms in the past with puppet, and eventually caused enough maintenance headaches that the community has had to do something about it.
</aside>