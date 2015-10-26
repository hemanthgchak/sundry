class Photo < ActiveRecord::Base

	validates :photo_reference, uniqueness: true

	def self.photo_url(width, height, photo_reference, attrib)
		@client = GooglePlaces::Photo.new(width, height, photo_reference, attrib, 'AIzaSyAZfXt-IGIEzhGEz20WjuG2x4OJve1M5wc')
		@client.fetch_url(1000)
	end


end
