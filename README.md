# Domain3

Lightweight Service, Form and Validator objects.

Decoupled and testable.

Leans heavily on other libraries.

*Service Objects*

* Dependency injection via initializer
* Broadcasting of sync or async events

*Forms Objects*

* Initialization from hash
* Attribute type coercion
* ActiveModel compliant (Rails only)
* Simple Validations

*Validators*

* Complicated validations, e.g. against entities

## Installation

```ruby
gem 'domain3'
```

## Usage

Using a little DSL, mostly objects:

```ruby
def new
  @form = RegisterUser.new_form(form_params)
end

def create
  @form = RegisterUser.new_form(form_params)

  command = RegisterUser.new

  command.subscribe(AuditListener.new)

  command.on(:success) { redirect_to :index }
  command.on(:failure) { render action: :new }

  command.execute(@form)
end
```

### Forms

```ruby
class RegisterUser
  class Form
    include D3::Form

    attribute :username, type: String, presence: true
    attribute :email,    type: String, presence: true
    attribute :password, type: String, presence: true
  end
end
```

The `Form` will have the [Lotus::Validations](https://github.com/lotus/validations) module included.

Where ActiveModel is present [ActiveModel::Conversion](http://api.rubyonrails.org/classes/ActiveModel/Model.html)
will be included.

### Services

```ruby
class RegisterUser
  include D3::Service

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

The service has [Wisper](https://github.com/krisleech/wisper) and [Medicine](https://github.com/krisleech/medicine) included.

Medicine provides a macro for declaring dependencies and their defaults.

Wisper provides broadcasting of events and subscribing of listeners.

### Validators

```ruby
class RegisterUser
  class Validator
    include D3::Validator

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
