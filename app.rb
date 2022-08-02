# frozen_string_literal: true

require 'bundler/setup'
require 'puma'
require 'roda'
require 'bridgetown-core'
require 'bridgetown-core/rack/boot'
require 'bridgetown'
require_relative 'app/api'
require_relative 'docs/server/roda_app'

Bridgetown::Rack.boot

class App < Roda
  route do |r|
    r.root { r.redirect '/docs' }
    r.on 'api/v1' do
      r.run Api.freeze.app
    end

    r.on 'docs' do
      r.run RodaApp.freeze.app
    end
  end
end
