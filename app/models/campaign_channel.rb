class CampaignChannel < ApplicationRecord
  belongs_to :campaign, inverse_of: :channel

  has_many :messages, as: :channel, dependent: :destroy
  has_many :users, through: :campaign
end
