class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public, :selected_encounter
  has_one :dm
  has_one :channel
  has_many :users
  has_many :encounters
end
