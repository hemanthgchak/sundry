class RadarSearch < ActiveRecord::Base
	validates :place_id, uniqueness: true
end