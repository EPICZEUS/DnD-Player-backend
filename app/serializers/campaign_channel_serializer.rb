class CampaignChannelSerializer < ActiveModel::Serializer
  attributes :id
  has_one :campaign
  has_many :messages
  has_many :users
end
