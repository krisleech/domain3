require 'wisper'
require 'medicine'

module Domain3
  module Service
    FormNotDefined = StandardError.new

    def self.included(recipient)
      recipient.class_eval do
        include Wisper.publisher
        include Medicine::DI
      end

      recipient.extend ClassMethods
    end

    module ClassMethods
      # Returns a Form object for the Service
      #
      def new_form(attributes = {})
        if defined?(self::Form)
          self::Form.new(attributes)
        else
          raise FormNotDefined, "Define #{name}::Form to use #new_form"
        end
      end
    end
  end
end
