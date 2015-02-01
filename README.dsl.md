```ruby
require 'domain3/dsl'
```

The service object must have a perform method which accepts a form-like object
and performs the command. At this point the form has been validated.

The service can then be called in the following ways:

```ruby
RegisterUser.run(form_params) do
  success { redirect_to :index }
  failure { redirect_to :index }

  subscribe(AuditListener.new)
end
```

```ruby
RegisterUser.run do
end
```

```ruby
result = RegisterUser.run(form)

if result.successful?
  redirect_to :index
else
  render action: :new
end
```


### Services

```ruby
class RegisterUser
  include Domain3::Service

  event      :user_registered
  dependency :user_repo, default: 'User',
             :validator, default: 'Validator'

  def perform(form)
    user = User.create!(form.attributes)
    success(user.id)
  end
end
```

The form will already be validated by calling `valid?` and if delcared as a
dependency a validator.

If the success method is called:

* A success event is broadcast
* A "user_registered" event is broadcast
* A truthy object which returns true for `successful?` is returned

If the failure method is called or success method is not called:

* A failure event is broadcast
* A "user_registered_failed" event is broadcast
* A falesy object which returns false for `successful?` is returned

If an exception occurs:

* A "exception" event is broadcast
* A "user_registered_error" event is broadcast
* A falesy object which returns false for `successful?` is returned
