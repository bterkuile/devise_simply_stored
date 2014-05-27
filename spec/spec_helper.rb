require 'rubygems'
require 'bundler/setup'
require 'devise_simply_stored'
Bundler.require
require 'pry'

# SETUP devise. Important to do before loading models
Devise.setup do |config|
  config.stretches = 1
  config.case_insensitive_keys = [ :email ]
  config.reset_password_within = 2.hours
end
Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each{|f| require f}
RSpec.configure do |config|
  # some (optional) config here
end
