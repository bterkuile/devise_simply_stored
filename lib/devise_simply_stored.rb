
require "devise_simply_stored/version"
#begin
  #require 'devise/orm/simply_stored'
#rescue
  require 'orm_adapter/adapters/simply_stored'
#end

# Initialize the module
module DeviseSimplyStored
end
