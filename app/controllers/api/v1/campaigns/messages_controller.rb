class Api::V1::Campaigns::MessagesController < ApplicationController
	before_action :find_campaign

	def index
		render json: @campaign.channel.messages
	end

	def create
		@message = Message.new(message_params)

		@message.channel = @campaign.channel
		@message.user = current_user

		if @message.save
			render json: { message: MessageSerializer.new(@message) }, status: :created

			ActionCable.server.broadcast "app_main", { type: ADD_MESSAGE, payload: MessageSerializer.new(@message)}
		else
			render json: { message: @message.errors.full_messages }, status: :not_acceptable
		end
	end

	private

	def message_params
		params.permit(:content)		
	end

	def find_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end
end
