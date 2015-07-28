require 'domain3'

class MyService
  include Domain3::Service

  class Form
    include Domain3::Form

    attribute :name, type: String
  end
end

RSpec.describe MyService do
  subject { MyService }

  describe '#new_form' do
    it 'returns nested Form object' do
      expect(subject.new_form).to be_instance_of(MyService::Form)
    end

    it 'returns nested Form object initialized with attributes' do
      name = 'Kris Leech'
      form = subject.new_form(name: name)
      expect(form.name).to eq name
    end
  end
end
