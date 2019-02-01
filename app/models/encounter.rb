class Encounter < ApplicationRecord
  belongs_to :campaign

  has_and_belongs_to_many :characters
  has_and_belongs_to_many :creatures

  before_validation :handle_image

  def handle_image
  	image_url_regex = /(https?:)([\/.\w\s-])*\.(?:jpe?g|gif|png)/

  	if !self.background_url.nil? && !self.background_url.empty?
  		unless self.background_url.match(image_url_regex)
	  		begin
	  			data = JSON.parse(RestClient.post('https://api.imgur.com/3/image', { image: self.background_url }, { Authorization: "Client-ID ca394538aa16c39" }))

	  			self.background_url = data["data"]["link"]
	  		rescue
	  			self.background_url = ""
	  		end
	  	end
  	else
  		self.background_url = ""
  	end
  end
end
