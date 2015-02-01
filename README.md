# Domain3

Lightweight Service, Form and Validator objects.

Decoupled and testable.

Leans heavily on other gems.

*Service Objects*

* Dependency injection via initializer
* Broadcasting of sync or async events

*Forms Objects*

* Initialization from hash
* Attribute type coercion
* ActiveModel compliant
* Validation

*Validators*

* Validate against external entities

## Installation

```ruby
gem 'domain3'
```

## Usage

Using a little DSL, mostly objects:

```ruby
def create
  form = RegisterUser::Form.new(form_params)

  command = RegisterUser.new

  command.subscribe(AuditListener.new)

  command.on(:success) { redirect_to :index }
  command.on(:failure) { render action: :new }

  command.execute(form)
end
```

### Forms

```ruby
class RegisterUser
  class Form
    include Domain3::Form

    attribute :username, String
    attribute :email,    String
    attribute :password, String

    validate :username, presense: true
    validate :email,    presense: true
    validate :password  presense: true
  end
end
```

The `Form` will have [ActiveModel::Validations]() and [Virtus]() gems included.

### Services

```ruby
class RegisterUser
  include Domain3:Service

  event      :user_registered
  dependency :user_repo, default: 'User',
             :validator, default: 'Validator'

  def execute(form)
    if validator.valid?(form)
      user = User.create!(form.attributes)

      broadcast(:success, user.id)
      broadcast(:user_registered, user.id)
    else
      broadcast(:failed, form)
    end
  end
end
```

The service has [Wisper]() and [Isopod]() included.

Isopod provides a macro for declaring dependencies and their defaults.

Wisper provides broadcasting of events and subscribing of listeners.

### Validators

```ruby
class RegisterUser
  class Validator
    dependency :user_repo, 'User'

    def validate(form)
      if user_repo.exists?(username: form.username)
        form.errors.add(:username, 'is already taken')
      end
    end
  end
end
```

## Contributing

Yes, please.
