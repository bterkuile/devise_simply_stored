class User
  include SimplyStored::Couch

  devise :database_authenticatable, :recoverable, :rememberable, :trackable
end
