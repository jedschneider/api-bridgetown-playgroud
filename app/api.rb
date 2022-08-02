# frozen_string_literal: true

require 'roda'
class Api < Roda
  plugin :json
  plugin :default_headers, 'Content-Type' => 'application/json'

  route do |r|
    @todos = [
      { id: 'abc123', task: 'Build routing tree', status: :incomplete },
      { id: '123abc', task: 'integrate bridgetown', status: :incomplete },
      { id: '123abc', task: 'make components', status: :incomplete }
    ]
    r.on 'todos' do
      r.is do
        r.get { @todos }
      end
      r.is String do |id|
        r.get { @todos.detect { _1[:id] == id } }
      end
    end
  end
end
