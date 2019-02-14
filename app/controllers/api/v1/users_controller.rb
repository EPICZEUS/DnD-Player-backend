class Api::V1::UsersController < ApplicationController
	skip_before_action :authorized, only: [ :create, :retrieve ]

	def index
		render json: User.all
	end

	def retrieve
		if logged_in?
			render json: { user: UserSerializer.new(current_user), token: encode_token({ user_id: current_user.id })}, status: :ok
		else
			render json: { message: "Please log in" }, status: :unauthorized
		end
	end

	def create
		@user = User.create(user_params)

		if @user.valid?
			render json: { user: UserSerializer.new(@user), token: encode_token({ user_id: @user.id })}, status: :created
		else
			render json: { errors: @user.errors.messages.keys, messages: @user.errors.full_messages }, status: :not_acceptable
		end
	end

	private

	def user_params
		params.permit(:username, :password, :first_name, :last_name, :avatar_url)
	end
end
