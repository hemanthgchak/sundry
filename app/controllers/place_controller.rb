class PlaceController < ApplicationController
	def index
	end

	def get_place_details
		@places  = Place.all

		render :json => @places
	end
end
