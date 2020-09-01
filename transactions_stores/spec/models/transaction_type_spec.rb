require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:origin) }
  end

  describe 'associations' do
    it { should have_many(:transactions) }
  end
end
