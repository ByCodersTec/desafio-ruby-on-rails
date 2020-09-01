class TransactionType < ApplicationRecord
  validates :description, :origin, presence: true

  has_many :transactions
end
