class Location < ActiveRecord::Base
	has_many :denizens

	geocoded_by :full_address
	reverse_geocoded_by :latitude, :longitude

	validates :city, :state, :country, presence: true	

	after_validation :geocode, if: :codable
	after_validation :reverse_geocode, if: :reverse_codable

	def dwellers
		denizens.map {|x| x.dweller}
	end	

	def full_address
		if address.present? && !address.empty?
			address
		else
			[street, city, state, country].compact.join(', ')
		end
	end

	private
	def codable
		(address_changed?) and ( !latitude? and !longitude?)
	end	

	def reverse_codable
		!address.present? && (latitude? && longitude?)
	end
end