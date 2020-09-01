class Transaction < ApplicationRecord
  validates :store, :amount, :recipient, :occurred_in, :transaction_type, presence: true

  belongs_to :transaction_type
  belongs_to :recipient
  belongs_to :store
end
