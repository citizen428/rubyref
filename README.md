# rubyref.net - Ruby documentation redirects

Source code for https://rubyref.net - a shorthand for navigating to [Ruby](https://www.ruby-lang.org) documentation. Inspired by [nocduro/rustref](https://github.com/nocduro/rustref).

Examples:

```
awesome.rubyref.net → https://github.com/markets/awesome-ruby
book.rubyref.net → http://ruby-doc.com/docs/ProgrammingRuby/
capi.rubyref.net → https://docs.ruby-lang.org/en/trunk/extension_rdoc.html
...
```

Built with [Middleman](http://middlemanapp.com), [Netlify](https://www.netlify.com)
and [CloudFlare](https://www.cloudflare.com)

The initial version built with [Roda](http://roda.jeremyevans.net) can still be seen in the
[roda branch](https://github.com/citizen428/rubyref/tree/roda).

## Overview

Middleman builds out a static `index.html` which gets deployed to Netlify. A [Cloudflare page rule](https://www.cloudflare.com/features-page-rules/) redirects all requests to `*.rubyref.net` (except
for `www`) to `https://rubyref.net/redirect/*`. This either uses a cached value at Cloudflare or gets [redirected by Netlify](https://www.netlify.com/docs/redirects/).

All redirect information is stored in `redirects.json`. Since Cloudflare does not offer wildcard proxied CNAME records, the `cloudflare:update_cnames` Rake task uses the [Cloudflare gem](https://github.com/ioquatix/cloudflare) to set them via the API before a new version of the app is
deployed.

CSS ~~copied~~ inspired by http://neverssl.com via http://rustref.com.

## Hosting/architecture

Browser -> Cloudflare (free tier) -> Netlify (free tier)

## Contributing

Modify `redirects.json` with a new redirect (in alphabetic order) then make a pull request.
