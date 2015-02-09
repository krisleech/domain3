# Rails DSL

Currently in lib/rails/* will be moved to a gem once finished.

gem 'domain3-rails'

This makes `D3::Form` activemodel compliant.

```ruby
class RegistrationController < ApplicationController
  include Domain3::Controller

  create RegisterUser do
    success { redirect_to :index }
    failure { render action: :new }

    subscribe(AuditListener.new)
  end
end
```

This maps to the following conventions:

A service object with a `perform` method which call a `success` method to
indicate a successful operation.

```ruby
class RegisterUser
  include D3::Service

  dependency :user_repo, 'User'

  def perform(form)
    user = user_repo.create!(form.attributes)
    success(user.id)
  end
end
```

A form object namespaced under the service class.

```
class RegisterUser::Form
  include D3::Form

  attribute :username

  validate :username, presence: true
end
```

An optional validator with a `validate` method for validating based on external
state.

```
class RegisterUserValidator
  include D3::Validator

  dependency :user_repo, 'User'

  def validate(form)
    if user_repo.exists?(username: form.username)
       form.errors.add(:username, 'is already taken')
    end
  end
end
```
