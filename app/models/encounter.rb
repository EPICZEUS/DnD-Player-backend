class Encounter < ApplicationRecord
  belongs_to :campaign

  has_many :positions, dependent: :destroy

  has_many :characters, through: :positions, source: :playable, source_type: 'Character'
  has_many :creatures, through: :positions, source: :playable, source_type: 'Creature'

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

  def characters=(data)
    data.each do |charData|
      character = Character.find(charData["id"])
      position = Position.new(charData["positions"].find { |e| !e[:encounter] }.permit("x", "y"))
      position.encounter = self
      position.playable = character

      position.save
      
      self.positions << position

      ActionCable.server.broadcast "app_main", { type: UPDATE_CHARACTER, payload: CharacterSerializer.new(character) }
    end
  end

  def creatures=(data)
    data.each do |creatureData|
      creature = Creature.find(creatureData["id"])
      position = Position.new(creatureData["positions"].find { |e| !e[:encounter] }.permit("x", "y"))
      position.encounter = self
      position.playable = creature

      position.save

      self.positions << position

      ActionCable.server.broadcast "app_main", { type: UPDATE_CREATURE, payload: CreatureSerializer.new(creature) }
    end
  end
end
