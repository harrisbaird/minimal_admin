module MinimalAdmin
  class Configuration
    def initialize
      @title = 'Minimal Admin'
      @stylesheets = [
        'https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha.3/css/bootstrap.css',
        '/stylesheets/global.css'
      ]
      @javascripts = [
        'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js',
        'https://cdnjs.cloudflare.com/ajax/libs/turbolinks/5.0.0/turbolinks.min.js',
        '/javascripts/global.js'
      ]
      @views = [MinimalAdmin.root.join('views').to_s]
    end

    attr_accessor :title, :stylesheets, :javascripts, :views
  end
end
