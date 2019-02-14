class AppChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{channel_name}_main"
  end

  def unsubscribed
  end

  def join(data)
  	@campaign = Campaign.find(data["campaign_id"])
  	@user = User.find(data["user_id"])

  	unless @campaign.users.any? { |e| e.id == @user.id }
  		@campaign.users << @user
  		@campaign.save

  		ActionCable.server.broadcast "app_main", { type: UPDATE_CAMPAIGN, payload: CampaignSerializer.new(@campaign) }
  	end
  end

  def add(data)
  	@encounter = Encounter.find_by(id: data["encounter_id"])

  	if @encounter
  		if data["type"] == "characters"
  			@character = Character.find(data["playable_id"])
  			@position = Position.new(x: data["position"]["x"], y: data["position"]["y"])

  			@character.positions << @position
  			@encounter.positions << @position
  		elsif data["type"] == "creatures"
  			@creature = Creature.find(data["playable_id"])
  			@position = Position.new(x: data["position"]["x"], y: data["position"]["y"])

  			@creature.positions << @position
  			@encounter.positions << @position
  		end

			@position.save

			if @character
  			ActionCable.server.broadcast "app_main", { type: UPDATE_CHARACTER, payload: CharacterSerializer.new(@character) }
			else
				ActionCable.server.	broadcast "app_main", { type: UPDATE_CREATURE, payload: CreatureSerializer.new(@creature) }
			end
			ActionCable.server.broadcast "app_main", { type: UPDATE_ENCOUNTER, payload: EncounterSerializer.new(@encounter) }
		else
			if data["type"] == "characters"
				@character = Character.find(data["playable_id"])
				@character.positions << Position.new(x: data["position"]["x"], y: data["position"]["y"])

				ActionCable.server.broadcast "app_main", { type: UPDATE_CHARACTER, payload: CharacterSerializer.new(@character) }
			elsif data["type"] == "creatures"
				@creature = Creature.find(data["playable_id"])
				@creature.positions << Position.new(x: data["position"]["x"], y: data["position"]["y"])

				ActionCable.server.broadcast "app_main", { type: UPDATE_CREATURE, payload: CreatureSerializer.new(@creature) }
			end
		end
  end

  def remove(data)
  	if data["type"] == "characters"
  		@character = Character.find(data["playable_id"])

  		ActionCable.server.broadcast "app_main", { type: UPDATE_CHARACTER, payload: CharacterSerializer.new(@character) }
  	elsif data["type"] == "creatures"
			@creature = Creature.find(data["playable_id"])

			ActionCable.server.broadcast "app_main", { type: UPDATE_CREATURE, payload: CreatureSerializer.new(@creature) }
		end
  end
end
