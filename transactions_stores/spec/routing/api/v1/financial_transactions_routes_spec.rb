require 'rails_helper'

RSpec.describe 'routes to the API::V1::FinancialTransactionsController', type: :routing do
  it 'GET index' do
    expect(get: api_v1_financial_transactions_path).
      to route_to(format: :json, controller: 'api/v1/financial_transactions', action: 'index')
  end
end
