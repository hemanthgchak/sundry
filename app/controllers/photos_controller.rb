class PhotosController < ApplicationController

	def get_photos
		@photos = Photo.all
		render :json => @photos
	end
end
