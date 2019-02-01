class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_one :channelable
  has_one :user
end
