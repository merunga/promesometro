#!/usr/bin/ruby

require 'rubygems'
require 'fcgi'
require 'rack'

ENV['RAILS_ENV'] ||= 'production'

# Set GEM_PATH and GEM_HOME ("user" is your dreamhost user)
ENV['GEM_HOME'] ||= '/home/promesometro/.gems'
require 'rubygems'
Gem.clear_paths

require 'config/environment'

class Rack::PathInfoRewriter
 def initialize(app)
   @app = app
 end

 def call(env)
   env.delete('SCRIPT_NAME')
   parts = env['REQUEST_URI'].split('?')
   env['PATH_INFO'] = parts[0]
   env['QUERY_STRING'] = parts[1].to_s
   @app.call(env)
 end
end

Rack::Handler::FastCGI.run  Rack::PathInfoRewriter.new(Promesometro::Application)
