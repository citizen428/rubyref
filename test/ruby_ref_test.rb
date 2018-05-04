# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/spec'
require 'rack/test'
require_relative '../ruby_ref'

describe 'RubyRef' do
  include Rack::Test::Methods

  def app
    RubyRef.app
  end

  it 'serves the landing page' do
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'rubyref.net'
  end

  it 'redirects all sites defined in redirect.json' do
    RubyRef::REDIRECTS.each do |cname, target|
      get "/redirect/#{cname}"
      assert last_response.redirect?
      assert last_response.location == target
    end
  end
end
