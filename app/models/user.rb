class User < ApplicationRecord
	has_secure_password

	has_many :dm_campaigns, class_name: "Campaign", inverse_of: :dm

	has_and_belongs_to_many :campaigns

	validates :username, presence: true, uniqueness: { case_sensitive: false }
	validates :password, presence: true
	
	before_validation :defaults

	def defaults
		self.first_name ||= ""
		self.last_name ||= ""

		self.first_name.capitalize!
		self.last_name.capitalize!

		if self.avatar_url.nil? || self.avatar_url.empty?
			self.avatar_url = Faker::Avatar.image
		end
	end
end
