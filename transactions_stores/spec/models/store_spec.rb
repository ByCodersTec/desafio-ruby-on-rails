require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner) }

    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:transactions) }
  end

  describe 'should return list of transactions by name' do
    let(:store) { 'Amazon' }

    before do
      Store.create(name: store, owner: 'Jeff Bezos')
    end

    it { expect(Store.by_name('Amazon').count).to eql(1) }
    it { expect(Store.by_name('Best Buy').count).to eql(0) }
  end
end
