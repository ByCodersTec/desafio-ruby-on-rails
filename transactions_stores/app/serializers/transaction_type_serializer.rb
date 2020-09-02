class TransactionTypeSerializer < ActiveModel::Serializer
  attributes :id, :description, :formatted_origin
end
