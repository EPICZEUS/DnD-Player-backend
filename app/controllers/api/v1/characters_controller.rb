class Api::V1::CharactersController < ApplicationController
	def index
		render json: Character.all
	end
end
