class Denizen < ActiveRecord::Base
	belongs_to :location
	belongs_to :dweller, :polymorphic => true
end
