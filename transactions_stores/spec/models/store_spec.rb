require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner) }
  end

  describe 'associations' do
    it { should have_many(:transactions) }
  end
end
