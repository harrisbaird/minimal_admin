require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/content_for'
require 'rack/flash'
require 'minimal_admin/helpers'

module MinimalAdmin
  class App < Sinatra::Base
    helpers Sinatra::ContentFor
    helpers MinimalAdmin::Helpers

    set :public_folder, File.join(root, '..', '..', 'public')
    set :views, File.join(root, '..', '..', 'views')

    enable :sessions
    use Rack::Flash, accessorize: [:success, :warning, :error]
    use Rack::MethodOverride
    use Rack::Deflater

    def self.setup_routes
      MinimalAdmin.dashboards.each do |dashboard|
        dashboard.setup_routes(self)
      end
    end

    not_found do
      status 404
      flash[:error] = "#{request.path} could not be found"
      redirect '/'
    end

    error do
      flash[:error] = 'An error occured: ' + env['sinatra.error'].message
      redirect '/'
    end

    get '/' do
      # TODO: Are any dashboards defined?
      redirect(path_for(MinimalAdmin.dashboards.first, :index))
    end

    get '/autocomplete/association' do
      model = params['model'].constantize
      adapter = MinimalAdmin::Adapter::Sequel.new(model)
      results = adapter.search(params['q']).map do |record|
        { id: record.id, text: record_label(record) }
      end
      json results: results
    end
  end
end
