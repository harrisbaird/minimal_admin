# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minimal_admin/version'

Gem::Specification.new do |spec|
  spec.name          = 'minimal_admin'
  spec.version       = MinimalAdmin::VERSION
  spec.authors       = ['harrisbaird']
  spec.email         = ['mydancake@gmail.com']

  spec.summary       = 'minimal_admin'
  spec.description   = 'minimal_admin'
  spec.homepage      = 'https://github.com/harrisbaird/minimal_admin'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'sinatra-contrib'
  spec.add_dependency 'rack-flash3'
  spec.add_dependency 'slim'
  spec.add_dependency 'sequel'


  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'sqlite3'
end
