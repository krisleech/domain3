require 'virtus'

module Domain3
  module Form

    def self.included(recipient)
      recipient.class_eval do
        include Virtus.model
      end

      super
    end
  end
end
