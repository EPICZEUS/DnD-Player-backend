class Api::V1::CampaignsController < ApplicationController
	def index
		render json: Campaign.all
	end

	def create
		@campaign = Campaign.new(campaign_params)

		@campaign.dm = current_user

		if @campaign.save
			@campaign.users << current_user
			@campaign.save

			render json: { campaign: CampaignSerializer.new(@campaign) }, status: :created
			ActionCable.server.broadcast "app_main", { type: ADD_CAMPAIGN, payload: CampaignSerializer.new(@campaign, include: [ "channel.*" ]) }
		else
			render json: { errors: @campaign.errors.messages.keys, messages: @campaign.errors.full_messages }, status: :not_acceptable
		end
	end

	def update
		@campaign = Campaign.find(params[:id])

		if @campaign.update(campaign_params)
			render json: { campaign: CampaignSerializer.new(@campaign) }, status: :accepted
			ActionCable.server.broadcast "app_main", { type: UPDATE_CAMPAIGN, payload: CampaignSerializer.new(@campaign) }
		else
			render json: { errors: @campaign.errors.messages.keys, messages: @campaign.errors.full_messages }, status: :not_acceptable
		end
	end

	def destroy
		@campaign = Campaign.find(params[:id])

		if @campaign.dm.id == current_user.id
			ActionCable.server.broadcast "app_main", { type: DELETE_CAMPAIGN, payload: @campaign.id }

			@campaign.destroy
		else
			render json: { message: "This campaign is not owned by you" }, status: :unauthorized
		end
	end

	private

	def campaign_params
		params.permit(:name, :description, :public, :selected_encounter)
	end
end
