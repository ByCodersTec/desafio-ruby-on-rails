class API::V1::FinancialTransactionsController < ApplicationController
  def index
    transactions = Transaction.by_store(Store.by_name(params[:store_name]))

    render json: transactions, meta: Transaction.total(params[:store_name]), status: :ok
  end
end