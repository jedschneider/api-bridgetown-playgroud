# frozen_string_literal: true

require 'bundler/setup'
require 'puma'
require 'roda'
require 'bridgetown'
require_relative 'app/api'

# Set config object up before requiring Bridgetown Rack boot
Bridgetown::Current.preloaded_configuration = Bridgetown.configuration(
  root_dir: File.expand_path("docs", __dir__),
  source: File.expand_path("docs/src", __dir__),
  destination: File.expand_path("docs/output", __dir__),
  base_path: "/" # we need to reset this from /docs to / because of the RodaApp mount point below
)

require 'bridgetown-core/rack/boot'
Bridgetown::Rack.boot # this will automatically load ./docs/server/*.rb

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
