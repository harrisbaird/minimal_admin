Bundler.require

require 'minimal_admin'
require 'minimal_admin/app'


require './test/support/sequel'
require './test/support/post_dashboard'
require './test/support/user_dashboard'

run MinimalAdmin::App
