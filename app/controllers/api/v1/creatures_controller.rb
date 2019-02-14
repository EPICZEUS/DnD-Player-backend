class Api::V1::CreaturesController < ApplicationController
	def index
		render json: Creature.all		
	end

	def delete_position
		@creature = Creature.find(params[:creature_id])
		@position = @creature.positions.find(params[:id])
		
		@encounter = @position.encounter

		@position.destroy
		
		ActionCable.server.broadcast "app_main", { type: UPDATE_CREATURE, payload: CharacterSerializer.new(@creature) }
		ActionCable.server.broadcast "app_main", { type: UPDATE_ENCOUNTER, payload: EncounterSerializer.new(@encounter) }
	end

	def adjust_position
		@creature = Creature.find(params[:creature_id])
		@position = @creature.positions.find(params[:id])

		if @position.update(position_params)
			render json: { position: PositionSerializer.new(@position) }, status: :accepted
			ActionCable.server.broadcast "app_main", { type: UPDATE_CREATURE, payload: CreatureSerializer.new(@creature) }
		else
			render json: { message: @position.errors.full_messages }, status: :not_acceptable
		end
	end

	private

	def position_params
		params.permit(:x, :y)
	end
end
