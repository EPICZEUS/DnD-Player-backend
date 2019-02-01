class CampaignChannelSerializer < ActiveModel::Serializer
  attributes :id
  has_one :campaign
end
