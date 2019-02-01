class Api::V1::AuthController < ApplicationController
	skip_before_action :authorized, only: [ :create ]

	def create
		unless auth
			render json: { message: "No login info provided" }, status: :unauthorized
		end

		encoded_login = auth.split(" ")[1]

		username, password = Base64.decode64(encoded_login).split(":")

		@user = User.find_by(username: username)

		if @user && @user.authenticate(password)
			render json: { user: UserSerializer.new(@user), token: encode_token({ user_id: @user.id })}, status: :accepted
		else
			render json: { message: "Invalid username or password" }, status: :unauthorized
		end
	end

	private

	def auth
		request.headers["Authorization"]
	end
end
