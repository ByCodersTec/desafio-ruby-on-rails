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

  describe 'should return the transactions by transaction type' do
    before do
      TransactionType.create(id: 1, description: 'Débito', origin: 0)
      TransactionType.create(id: 2, description: 'Boleto', origin: 1)
      TransactionType.create(id: 3, description: 'Financiamento', origin: 1)
    end

    it { expect(TransactionType.by_origin(:in)).to eql([1]) }
    it { expect(TransactionType.by_origin(:in)).to_not be_empty }

    it { expect(TransactionType.by_origin(:out)).to eql([2, 3]) }
    it { expect(TransactionType.by_origin(:out)).to_not be_empty }
  end

  describe 'should return the transactions' do
    let(:amazon) { Store.create(name: 'Amazon', owner: 'Jeff Bezos') }
    let(:target) { Store.create(name: 'Target', owner: 'George Draper Dayton') }

    let(:debit)     { TransactionType.create(id: 1, description: 'Débito', origin: 0) }
    let(:bank_slip) { TransactionType.create(id: 2, description: 'Boleto', origin: 1) }
    let(:financing) { TransactionType.create(id: 3, description: 'Financiamento', origin: 1) }
    
    let(:recipient) { Recipient.create(cpf: '12345678900', card: '4753****3153') }

    before do
      Transaction.create(store: amazon,
                         amount: 550.00,
                         recipient: recipient,
                         transaction_type: debit,
                         occurred_in: DateTime.now)
    end

    describe 'by store' do
      it { expect(Transaction.by_store(amazon)).to_not be_empty }
      it { expect(Transaction.by_store(amazon).count).to eql(1) }

      it { expect(Transaction.by_store(target)).to be_empty }
      it { expect(Transaction.by_store(target).count).to eql(0) }
    end

    describe 'total' do
      let(:best_buy) { Store.create(name: 'Best Buy', owner: 'Richard Schulze') }

      before do
        Transaction.create(store: amazon,
                           amount: 1000.00,
                           recipient: recipient,
                           occurred_in: DateTime.now,
                           transaction_type: financing)

        Transaction.create(store: best_buy,
                           amount: 0.01,
                           recipient: recipient,
                           transaction_type: debit,
                           occurred_in: DateTime.now)

        Transaction.create(store: best_buy,
                           amount: 99.99,
                           recipient: recipient,
                           transaction_type: debit,
                           occurred_in: DateTime.now)
      end

      it { expect(Transaction.total(target.name)).to eql(0) }
      it { expect(Transaction.total(amazon.name)).to eql(-450.000) }
      it { expect(Transaction.total(best_buy.name)).to eql(100.00) }
    end
  end
end
