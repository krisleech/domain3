require 'lotus/validations'

# Module to give a Class form object behaviour
#
# When ActiveModel is defined the form is also ActiveModel compliant

module Domain3
  module Form
    def self.included(recipient)
      recipient.class_eval do
        include Lotus::Validations
      end

      ActiveModelIntegration.setup(recipient) if defined?(::ActiveModel)

      super
    end

    module ActiveModelIntegration
      def self.setup(recipient)
        recipient.class_eval do
          include ::ActiveModel::Conversion
          extend InstanceMethods
        end
      end

      module InstanceMethods
        def persisted?
          false
        end
      end
    end

    private_constant :ActiveModelIntegration
  end
end
