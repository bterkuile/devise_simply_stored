devise_simply_stored
=========================

add it to your Gemfile:
```ruby
gem 'devise_simply_stored'
```

to use in your model:
```ruby
class User
  include SimplyStored::Couch

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
```

== Devise version warning!!
devise_simply_stored up till 0.0.3 works with devise 2.0.4. Since version 0.1.0 it is tested against devise 3.1.0. This is 
breaking upgrade since devise has changed a lot since this version.
A typical Gemfile from version 0.1.0 looks like:
```ruby
gem 'couch_potato' , github: 'bterkuile/couch_potato'
gem 'simply_stored' , github: 'bterkuile/simply_stored'
gem 'orm_adapter', github: 'bterkuile/orm_adapter'
gem 'devise', '>= 3.1.0'
gem 'devise_simply_stored' '>= 0.1.0'
```

Note that orm_adapter is a modified version

Note on Patches/Pull Requests
----------------------------------
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
-----------------

Copyright (c) 2012 Benjamin ter Kuile. See LICENSE for details.
