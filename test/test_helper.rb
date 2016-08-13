require 'minitest/autorun'
require 'minitest/capybara'

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minimal_admin'
require 'minimal_admin/app'

require 'support/sequel'
require 'support/post_dashboard'
require 'support/user_dashboard'

Capybara.app = MinimalAdmin::App
