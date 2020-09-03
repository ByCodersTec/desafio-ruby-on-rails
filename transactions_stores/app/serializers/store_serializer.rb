class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :owner, :formatted_total
end
