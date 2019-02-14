class Api::V1::Campaigns::EncountersController < ApplicationController
	before_action :find_campaign

	def index
		render json: @campaign.encounters, include: ['creatures.*', 'characters.*', 'campaign.*']
	end

	def create
		@encounter = Encounter.new(encounter_params)
		@encounter.campaign = @campaign

		@encounter.creatures = params["creatures"]
		@encounter.characters = params["characters"]

		if @encounter.save
			@campaign.update(selected_encounter: @encounter.id)

			render json: { encounter: EncounterSerializer.new(@encounter) }, status: :created, include: ['creatures.*', 'characters.*']
			ActionCable.server.broadcast "app_main", { type: ADD_ENCOUNTER, payload: EncounterSerializer.new(@encounter, include: ['creatures.*', 'characters.*']) }
			ActionCable.server.broadcast "app_main", { type: UPDATE_CAMPAIGN, payload: CampaignSerializer.new(@campaign) }
		else
			render json: { message: @encounter.errors.full_messages }, status: :not_acceptable
		end
	end

	def update
		@encounter = @campaign.encounters.find(params[:id])

		if @encounter.update(encounter_params)
			render json: { encounter: EncounterSerializer.new(@encounter) }, status: :accepted, include: ['creatures.*', 'characters.*']
			ActionCable.server.broadcast "app_main", { type: UPDATE_ENCOUNTER, payload: EncounterSerializer.new(@encounter, include: ['creatures.*', 'characters.*']) }
		else
			render json: { message: @encounter.errors.full_messages }, status: :not_acceptable
		end
	end

	def destroy
		@encounter = @campaign.encounters.find(params[:id])

		if @encounter.campaign.dm.id == current_user.id
			@campaign.update(selected_encounter: nil)

			ActionCable.server.broadcast "app_main", { type: UPDATE_CAMPAIGN, payload: CampaignSerializer.new(@campaign) }
			ActionCable.server.broadcast "app_main", { type: DELETE_ENCOUNTER, payload: @encounter.id }

			@encounter.destroy
		else
			render json: { message: "This campaign does not belong to you" }, status: :unauthorized
		end
	end

	private

	def encounter_params
		params.permit(:name, :description)
	end

	def find_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end
end
