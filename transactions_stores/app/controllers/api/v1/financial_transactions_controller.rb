class API::V1::FinancialTransactionsController < ApplicationController
  def index
    transactions = Transaction.by_store(Store.by_name(params[:store_name]))

    render json: transactions, status: :ok
  end
end