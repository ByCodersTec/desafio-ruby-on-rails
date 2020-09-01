class Recipient < ApplicationRecord
  validates :cpf, :card, presence: true

  has_many :transactions
end
