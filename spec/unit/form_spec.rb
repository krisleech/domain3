require 'domain3/form'

module Domain3
  RSpec.describe Form do

    subject do
      Class.new do
        include Form
      end
    end

    describe 'inclusions' do
      it 'includes validations module' do
        expect(subject.included_modules).to include Lotus::Validations
      end

      describe 'when ActiveModel is defined' do
        before do
          stub_const('ActiveModel', Module.new)
          stub_const('ActiveModel::Conversion', Module.new)
        end

        it 'includes ActiveModel::Conversion' do
          expect(subject.included_modules).to include ActiveModel::Conversion
        end

        describe '#persisted?' do
          it 'is defined' do
            expect(subject).to respond_to 'persisted?'
          end

          it 'returns false' do
            expect(subject.persisted?).to be false
          end
        end
      end

      describe 'when ActiveModel is not defined' do
        it 'excludes ActiveModel::Conversion' do
          expect(subject.included_modules.map(&:to_s)).not_to include "ActiveModel::Conversion"
        end
      end
    end # inclusions
  end # describe
end # module
