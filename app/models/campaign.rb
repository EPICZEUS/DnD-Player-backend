class Campaign < ApplicationRecord
  belongs_to :dm, class_name: "User", foreign_key: "user_id"

  has_one :channel, class_name: "CampaignChannel", dependent: :destroy
  
  has_and_belongs_to_many :users

  has_many :encounters, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  after_initialize :defaults

  def defaults
  	self.channel ||= CampaignChannel.create
  end
end
