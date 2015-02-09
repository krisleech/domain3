begin
  require 'active_model'
rescue LoadError
  warn "You need to add ActiveModel to Gemfile"
  raise
end

# Rails ~>3 has no ActiveModel::Model,
# in Rails ~> 4 it includes the various parts of activemodel and
# defines persisted? to return false.
# ActiveModel::Model also defines a initializer, but we are using
# Virtus for this.
# Therefore we don't want to use ActiveModel::Model but reproduce it.

module Domain3
  module Rails
    module Form
      def self.included(recipient)
        recipient.module_eval do
          # not working
          # include ActiveModel::Model
          # monkey patching is a no-no, it breaks tests as the
          # monkey patch permanently applies.
        end

        super
      end
    end
  end
end

Domain3::Form.class_eval { include Domain3::Rails::Form }
