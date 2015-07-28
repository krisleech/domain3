require 'virtus'

module Domain3
  module Form
    def self.included(recipient)
      recipient.class_eval do
        include Virtus.model
      end

      load_active_model(recipient) if defined?(::ActiveModel)

      super
    end

    def self.load_active_model(recipient)
      recipient.class_eval do
        include ActiveModel::Model
      end
    end
  end
end
