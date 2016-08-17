module MinimalAdmin
  class Configuration
    def initialize
      @title = 'Minimal Admin'
      @views = [MinimalAdmin.root.join('views').to_s]
    end

    attr_accessor :title, :views
  end
end
