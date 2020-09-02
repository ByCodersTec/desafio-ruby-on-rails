class Transaction < ApplicationRecord
  validates :store, :amount, :recipient, :occurred_in, :transaction_type, presence: true

  belongs_to :store
  belongs_to :recipient
  belongs_to :transaction_type

  scope :by_store, -> (store) { where(store: store) }
  scope :by_transaction_types, -> (ids) { where(transaction_type: ids) }

  def self.total(store_name)
    total_in = 0
    total_out = 0

    store = Store.by_name(store_name)
    store_transactions = Transaction.by_store(store)

    store_transactions.by_transaction_types(TransactionType.by_origin(:in)).each { |transaction| total_in += transaction.amount }
    store_transactions.by_transaction_types(TransactionType.by_origin(:out)).each { |transaction| total_out -= transaction.amount }

    total_in + total_out
  end

  def formatted_amount
    ActionController::Base.helpers.number_to_currency(self.amount, unit: 'R$', delimiter: '.', separator: ',', format: '%u %n') 
  end

  def formatted_occurred_in
    self.occurred_in.strftime("%d/%m/%Y %H:%M:%S")
  end
end
