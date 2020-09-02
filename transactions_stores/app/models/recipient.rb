class Recipient < ApplicationRecord
  validates :cpf, :card, presence: true
  validates :cpf, uniqueness: { scope: [:card] }

  has_many :transactions
end
