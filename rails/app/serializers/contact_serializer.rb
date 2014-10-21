class ContactSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :frequency, :name
  has_many :conversations
end
