class Store < ApplicationRecord
  validates :name, :owner, presence: true
  validates :name, uniqueness: true

  has_many :transactions

  scope :by_name, -> (store_name) { where(name: store_name) }
end
