require 'domain3/service'

module Domain3
  RSpec.describe Service do

    describe 'inclusions' do
      subject { Class.new { include Service } }

      it 'includes Wisper::Publisher' do
        expect(subject.included_modules).to include Wisper::Publisher
      end

      it 'includes Medicine::DI' do
        expect(subject.included_modules).to include Medicine::DI
      end
    end # inclusions

    describe '#new_form' do
      describe 'when nested Form class defined' do
        subject { Class.new { include Service } }

        let(:form_class) do
          Class.new do
            def initialize(*args); end
          end
        end

        before { subject::Form = form_class }

        it 'returns Form object' do
          expect(subject.new_form).to be_instance_of(form_class)
        end
      end

      describe 'when nested Form class not defined' do
        subject do
          Class.new do
            include Service

            def self.name
              "MyService"
            end
          end
        end

        it 'raise an error' do
          expect { subject.new_form }.to raise_error('Define MyService::Form to use #new_form')
        end
      end
    end # new_form
  end # describe
end # module
