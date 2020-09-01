require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:store) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:recipient) }
    it { should validate_presence_of(:occurred_in) }
    it { should validate_presence_of(:transaction_type) }
  end

  describe 'associations' do
    it { should belong_to(:store) }
    it { should belong_to(:recipient) }
    it { should belong_to(:transaction_type) }
  end
end
