class User
  include SimplyStored::Couch
  include Devise::Orm::SimplyStored

  devise :database_authenticatable, :recoverable, :rememberable, :trackable 
end
