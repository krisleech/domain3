require 'wisper'
require 'medicine'

module Domain3
  module Service
    def self.included(recipient)
      recipient.class_eval do
        include Wisper.publisher
        include Medicine::DI
      end
    end
  end
end
