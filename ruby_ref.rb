# frozen_string_literal: true

require 'roda'
require 'json'

class RubyRef < Roda
  REDIRECTS = JSON.parse(File.read('redirects.json'))

  plugin :assets, css: 'style.css'
  plugin :render

  route do |r|
    r.assets

    r.root do
      render :index
    end

    r.on 'redirect', String do |subdomain|
      r.redirect REDIRECTS.fetch(subdomain) { '/' }
    end

    r.redirect '/'
  end
end
