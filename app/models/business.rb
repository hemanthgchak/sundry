class Business < ActiveRecord::Base
	has_many :denizens, :as => :dweller
	#has_many :locations, :through => :denizen

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true

	def locations
		denizens.map {|x| x.location}
	end
end