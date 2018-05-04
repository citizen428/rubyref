# frozen_string_literal: true

# Added this to avoid encoding errors on App Engine
Encoding.default_external = 'UTF-8'

require_relative 'ruby_ref'

run RubyRef.freeze.app
