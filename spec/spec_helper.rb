require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'devise_simply_stored'

# SETUP devise. Important to do before loading models
Devise.setup do |config|
  config.stretches = 10
  config.case_insensitive_keys = [ :email ]
  config.reset_password_within = 2.hours
end
Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each{|f| require f}
RSpec.configure do |config|
  # some (optional) config here
end
