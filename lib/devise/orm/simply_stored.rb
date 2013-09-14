require 'devise'
require 'orm_adapter/adapters/simply_stored'
SimplyStored::Couch::ClassMethods.send :include, Devise::Models
module SimplyStored::DeviseSchema
  SCHEMA_DEVS = {
    database_authenticatable: ->{
      property :encrypted_password, type: String, default: ""
    },
    recoverable: ->{
      property :reset_password_token,   type: String
      property :reset_password_sent_at, type: Time
    },
    rememberable: ->{
      property :remember_created_at, type: Time
    },
    trackable: ->{
      property :sign_in_count,      type: Fixnum, default: 0
      property :current_sign_in_at, type: Time
      property :last_sign_in_at,    type: Time
      property :current_sign_in_ip, type: String
      property :last_sign_in_ip,    type: String
    },
    confirmable: ->{
      property :confirmation_token,   type: String
      property :confirmed_at,         type: Time
      property :confirmation_sent_at, type: Time
      property :unconfirmed_email,    type: String # Only if using reconfirmable
    },
    locable: ->{
      property :failed_attempts, type: Fixnum, default: 0 # Only if lock strategy is :failed_attempts
      property :unlock_token,    type: String # Only if unlock strategy is :email or :both
      property :locked_at,       type: Time
    }
  }
  def devise_modules_hook!
    yield
    # Apply schema to model
    devise_modules.each do |m|
      if definition = SCHEMA_DEVS[m]
        instance_exec(&definition)
      end
    end
    Devise.authentication_keys.each do |key|
      property key, type: String unless respond_to?(key)
    end
  end
end
SimplyStored::Couch::ClassMethods.send :include, SimplyStored::DeviseSchema
module SimplyStored::Couch
  def [](val)
    attributes[val]
  end
end
