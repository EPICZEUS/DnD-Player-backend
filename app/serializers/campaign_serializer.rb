class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public
  has_one :dm
  has_many :users
  has_many :encounters
end
