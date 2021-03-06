# Summary

* wraps `whois` and removes the registrar boilerplate legal/marketing spam BS
* pass in a FQDN and it checks it
* pass in a base name and it checks for .com,.net,.org,etc.

# Install

    gem install whos
    
## Optional Install

    echo "alias whois=whos" >> ~/.bash_profile
    
# Usage

`whos foo.com` - runs `whois foo.com`. If it is available, or not, it says so in a single line.

`whos -v foo.com` - If `foo.com` is not available, it shows you the whois response, minus the boilerplate legal/marketing registrar text

`whos foo` - runs `whos foo.com` then `whos foo.com` then `whos foo.net` then `whos foo.org` etc.

`whos -o foo.com` - If `foo.com` is taken, opens `http://foo.com` in a browser

Multiple args work as expected.

# Got more spam?

Fork <http://github.com/alexch/whos> on github, add a file to the spam folder, run `rake install`, then send me a pull request

# Credits

Written in a fit of pique by Alex Chaffee <http://alexch.github.com>

# Possible Improvements

* local spam db e.g. ~/.whos/annoyingregistrar.txt
* shared spam db _a la_ [cheat](http://cheat.errtheblog.com)
* specify TLDs (currently: com net org biz info us it)
* BUG: an error in DNS lookup comes through as "not available" (or maybe "available" -- either way we need three states)
* BUG: doesn't recognize annoying "WHOIS LIMIT EXCEEDED" from .org registrar http://www.pir.org/WHOIS#q5

# Similar

* http://domai.nr/
* https://github.com/weppos/whois

# Release History

== 0.1.2 2011/08/07
* First real release

== 0.1.3 2011/08/24
* Added verisign spam

== 0.1.4 2011/09/01
* Fixed "host" bug in --open option`	`
* More spam

== 0.1.6 2011/09/02
* Fixed whitespace matching bug (catches way more spam now)
* Oops! spam db was not included by gemspec!

== 0.2.0 2011/09/06
* More TLDs (com net org biz info us)
* Parallel lookup (much faster)
* More spam
* Cleaner verbose output

== 0.2.1 2011/09/15
* More spam

==
* add .it TLD

