class Api::V1::CreaturesController < ApplicationController
	def index
		render json: Creature.all		
	end
end
