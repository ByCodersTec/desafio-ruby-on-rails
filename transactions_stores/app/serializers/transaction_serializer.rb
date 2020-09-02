class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :formatted_amount, :formatted_occurred_in

  belongs_to :store
  belongs_to :recipient
  belongs_to :transaction_type
end
