class Store < ApplicationRecord
  validates :name, :owner, presence: true
  validates :name, uniqueness: true

  has_many :transactions
end
