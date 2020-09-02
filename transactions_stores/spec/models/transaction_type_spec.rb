require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:origin) }
  end

  describe 'associations' do
    it { should have_many(:transactions) }
  end

  describe 'enums' do
    describe 'origin' do
      it { should define_enum_for(:origin).with_values([:in, :out]) }
    end
  end

  describe 'should return list of ids from transactions types by origin' do
    before do
      TransactionType.create(id: 2, description: 'Débito', origin: 1)
      TransactionType.create(id: 3, description: 'Financiamento', origin: 1)
    end

    it { expect(TransactionType.by_origin(:in)).to eql([]) }
    it { expect(TransactionType.by_origin(:in)).to be_empty }

    it { expect(TransactionType.by_origin(:out)).to eql([2, 3]) }
    it { expect(TransactionType.by_origin(:out)).to_not be_empty }
  end
end
