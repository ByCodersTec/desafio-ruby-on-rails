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
end
