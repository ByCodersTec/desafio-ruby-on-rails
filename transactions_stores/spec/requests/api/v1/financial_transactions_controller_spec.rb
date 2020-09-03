require 'rails_helper'

RSpec.describe FinancialTransactionsController, type: :request do
  describe 'GET index' do
    let(:debit)     { TransactionType.create(id: 1, description: 'Débito', origin: 0) }
    let(:best_buy)  { Store.create(name: 'Best Buy', owner: 'Richard Schulze') }
    let(:recipient) { Recipient.create(cpf: '12345678900', card: '4753****3153') }

    let(:transaction) { Transaction.create(store: best_buy,
                                          amount: 1000.00,
                                          recipient: recipient,
                                          transaction_type: debit,
                                          occurred_in: DateTime.now) }

    it 'returns a 200 and no transaction' do
      get '/v1/financial_transactions'

      expect(response).to have_http_status(:ok)
      expect(response.body).to eql("[]")
    end

    it 'returns a 200 and transaction list' do
      transactions = [
        { 
          id: transaction.id,
          formatted_amount: transaction.formatted_amount,
          formatted_occurred_in: transaction.formatted_occurred_in,
          store: { id: best_buy.id, name: best_buy.name, owner: best_buy.owner, formatted_total: best_buy.formatted_total },
          recipient: { id: recipient.id, cpf: recipient.cpf, card: recipient.card },
          transaction_type: { id: debit.id, description: debit.description, formatted_origin: debit.formatted_origin }
        }
      ].to_json

      get '/v1/financial_transactions', params: { store_name: 'Best Buy' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eql(transactions)
    end
  end
end
