# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
ENV['GEM_HOME'] ||= '/home/promesometro/.gems'
require 'rubygems'
run Promesometro::Application
