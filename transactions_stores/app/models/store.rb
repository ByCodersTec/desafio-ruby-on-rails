class Store < ApplicationRecord
  validates :name, :owner, presence: true

  has_many :transactions
end
