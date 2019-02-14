class Api::V1::CharactersController < ApplicationController
	def index
		render json: Character.all
	end

	def create
		@character = Character.new(character_params)

		@character.user = current_user

		if @character.save
			render json: { character: CharacterSerializer.new(@character) }, status: :created

			ActionCable.server.broadcast "app_main", { type: ADD_CHARACTER, payload: CharacterSerializer.new(@character) }
		else
			render json: { props: @message.errors.messages.keys, messages: @message.errors.full_messages }, status: :not_acceptable
		end
	end

	def delete_position
		@character = Character.find(params[:character_id])
		@position = @character.positions.find(params[:id])
		
		@encounter = @position.encounter

		@position.destroy
		
		ActionCable.server.broadcast "app_main", { type: UPDATE_CHARACTER, payload: CharacterSerializer.new(@character) }
		ActionCable.server.broadcast "app_main", { type: UPDATE_ENCOUNTER, payload: EncounterSerializer.new(@encounter) }
	end

	def adjust_position
		@character = Character.find(params[:character_id])
		@position = @character.positions.find(params[:id])

		if @position.update(position_params)
			render json: { position: PositionSerializer.new(@position) }, status: :accepted

			ActionCable.server.broadcast "app_main", { type: UPDATE_CHARACTER, payload: CharacterSerializer.new(@character) }
		else
			render json: { message: @position.errors.full_messages }, status: :not_acceptable
		end
	end

	private

	def character_params
		params.permit(:name, :level, :alignment, :char_class, :race, :speed, :campaign_id, :armor_class, :hp, :str, :dex, :con, :int, :wis, :cha)
	end

	def position_params
		params.permit(:x, :y)
	end
end
