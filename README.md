# rubyref.net - Ruby documentation redirects
Source code for https://rubyref.net - a shorthand for navigating to [Ruby](https://www.ruby-lang.org) documentation. Heavily inspired by [nocduro/rustref](https://github.com/nocduro/rustref).

Examples:
```
awesome.rubyref.net → https://github.com/markets/awesome-ruby
book.rubyref.net → http://ruby-doc.com/docs/ProgrammingRuby/
capi.rubyref.net → https://docs.ruby-lang.org/en/trunk/extension_rdoc.html
...
```

Built with ❤️ and [Roda](http://roda.jeremyevans.net).

## Overview

A [Cloudflare page rule](https://www.cloudflare.com/features-page-rules/) redirects all requests to `*.rubyref.net` to `https://rubyref.net/redirect/*`. This either uses a cached value at Cloudflare,
or makes a request to the Roda app which will respond with the appropriate 302 redirect.

All redirect information is stored in `redirects.json`. Since Cloudflare does not offer wildcard proxied CNAME records, the `cloudflare:update_cnames` Rake task uses the [Cloudflare gem](https://github.com/ioquatix/cloudflare) to set them via the API before a new version of the app is
deployed.

CSS ~~copied~~ inspired by http://neverssl.com via http://rustref.com.

## Hosting/architecture
Browser -> Cloudflare (free tier) -> Google Cloud Platform free tier (US Central) -> Roda app with Puma

## Contributing
Modify `redirects.json` with a new redirect (in alphabetic order) then make a pull request.
