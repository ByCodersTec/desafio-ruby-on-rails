class Store < ApplicationRecord
  validates :name, :owner, presence: true
  validates :name, uniqueness: true

  has_many :transactions

  scope :by_name, -> (store_name) { where(name: store_name) }

  def formatted_total
    ActionController::Base.helpers.number_to_currency(Transaction.total(name), unit: 'R$', delimiter: '.', separator: ',', format: '%u %n')
  end
end
