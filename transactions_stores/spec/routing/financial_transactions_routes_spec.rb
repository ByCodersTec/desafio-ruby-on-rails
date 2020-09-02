require 'rails_helper'

RSpec.describe 'routes to the FinancialTransactionController', type: :routing do
  it 'GET new' do
    expect(get: new_financial_transaction_path).
      to route_to(controller: 'financial_transactions', action: 'new')
  end

  it 'POST create' do
    expect(post: financial_transactions_path).
      to route_to(controller: 'financial_transactions', action: 'create')
  end
end