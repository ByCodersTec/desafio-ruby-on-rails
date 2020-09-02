class TransactionType < ApplicationRecord
  validates :description, :origin, presence: true

  has_many :transactions

  enum origin: { in: 0, out: 1 }
end
