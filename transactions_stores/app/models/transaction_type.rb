class TransactionType < ApplicationRecord
  validates :description, :origin, presence: true

  has_many :transactions

  enum origin: { in: 0, out: 1 }

  scope :by_origin, -> (origin) { where(origin: origin).ids }

  def formatted_origin
    self.origin == :in ? 'Entrada' : 'Saída'
  end
end
