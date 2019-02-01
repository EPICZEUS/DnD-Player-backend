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
		else
			render json: { message: @campaign.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@campaign = Campaign.find(params[:id])

		if @campaign.dm.id == current_user.id
			@campaign.destroy
		else
			render json: { message: "This campaign is not owned by you" }, status: :unauthorized
		end
	end

	private

	def campaign_params
		params.permit(:name, :description, :public)
	end
end
