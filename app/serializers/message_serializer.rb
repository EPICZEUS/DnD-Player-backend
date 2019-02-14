class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at
  has_one :channel
  has_one :user
end
