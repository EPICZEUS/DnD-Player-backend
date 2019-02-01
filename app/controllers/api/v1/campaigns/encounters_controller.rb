class Api::V1::Campaigns::EncountersController < ApplicationController
	before_action :find_campaign

	def index
		render json: @campaign.encounters
	end

	def create
		@encounter = Encounter.new(encounter_params)
		@encounter.campaign = @campaign

		if @encounter.save
			render json: { encounter: @encounter }, status: :created
		else
			render json: { message: @encounter.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def encounter_params
		params.permit(:name, :description, :character_ids, :creature_ids)
	end

	def find_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end
end
