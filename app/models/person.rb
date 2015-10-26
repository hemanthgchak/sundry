class Person < ActiveRecord::Base
	has_many :denizens, :as => :dweller
	#has_many :locations, :through => :denizen

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true

	def locations
		denizens.map {|x| x.location}
	end

	def self.import(file)
		p file.path
		CSV.foreach(file.path, headers: true, skip_blanks: true, skip_lines: /^(?:,\s*)+$/) do |row|
			p row			
			person = Person.find_by_id(row["id"]) || Person.find_by_email(row["email"]) || new
			p attrib = row.to_hash.slice("name", "email", "phone")
			person.attributes = attrib
			person.save!

			p "person saved with #{person.id}"

			if row["location_id"].present? or row["address"].present? or row["latitude"].present? or row["longitude"].present?
				location_index = row["location_id"] 
				location = Location.find_by_id(location_index) || Location.new
				location.attributes = row.to_hash.slice("latitude", "longitude", "address", "pincode", "city", "state", "country")
				location.save!
				p "location saved with #{location.id}"

				if Denizen.where(:location_id => location.id, :dweller_type => 'Person',:dweller_id => person.id).count == 0
					denizen = Denizen.new
					denizen.location_id = location.id
					denizen.dweller_type = Person.name
					denizen.dweller_id = person.id
					denizen.save!
					p "denizen saved with #{denizen.id}"
				end
			end
		end
	end

	def self.to_csv
		CSV.generate do |csv|
			csv << ["id", "name","email","phone"] + ["location_id"] + (Location.column_names - ["id"])
			all.each do |person|
				person_a = person.attributes.values_at("id","name","email","phone")
				if person.locations.any?
					person.locations.each do |location|
						location_a = location.attributes.values_at(*Location.column_names)
						csv << person_a + location_a
					end
				else
					csv << person_a
				end
			end
		end
	end
end
