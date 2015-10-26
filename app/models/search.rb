class Search 

	def initialize
		@client = GooglePlaces::Client.new('')
	end

	def radar_search(lat=12.906131, long=77.586965, radius=800)
		#@client = GooglePlaces::Client.new('')
		spots = @client.spots_by_radar(lat,long, :types => 'food', :radius=> radius)
		p spots.count
		spote = spots[3..-1]
		p spote
		spote.each do |spot|
			p "******************start of insert******************"
			p spot.inspect
			r = RadarSearch.new
			r.lat = spot.lat
			r.long = spot.lng
			r.g_id = spot.id
			r.place_id = spot.place_id
			r.save
			p "******************end of insert******************"
		end		
	end

	def radar_search_all(lat=12.906131, long=77.586965, radius=800)
		categories = ["amusement_park" , "aquarium" , "art_gallery" , "atm" , "bakery" , "bank" , "bar" , "beauty_salon" , "bicycle_store" , "book_store" , "bowling_alley" , "bus_station" , "cafe" , "campground" , "car_dealer" , "car_rental" , "car_repair" , "car_wash" , "casino" , "cemetery" , "church" , "city_hall" , "clothing_store" , "convenience_store" , "courthouse" , "dentist" , "department_store" , "doctor" , "electrician" , "electronics_store" , "embassy" , "establishment" , "finance" , "fire_station" , "florist" , "food" , "funeral_home" , "furniture_store" , "gas_station" , "general_contractor" , "grocery_or_supermarket" , "gym" , "hair_care" , "hardware_store" , "health" , "hindu_temple" , "home_goods_store" , "hospital" , "insurance_agency" , "jewelry_store" , "laundry" , "lawyer" , "library" , "liquor_store" , "local_government_office" , "locksmith" , "lodging" , "meal_delivery" , "meal_takeaway" , "mosque" , "movie_rental" , "movie_theater" , "moving_company" , "museum" , "night_club" , "painter" , "park" , "parking" , "pet_store" , "pharmacy" , "physiotherapist" , "place_of_worship" , "plumber" , "police" , "post_office" , "real_estate_agency" , "restaurant" , "roofing_contractor" , "rv_park" , "school" , "shoe_store" , "shopping_mall" , "spa" , "stadium" , "storage" , "store" , "subway_station" , "synagogue" , "taxi_stand" , "train_station" , "travel_agency" , "university" , "veterinary_care" , "zoo"] 

		categories.each do |category|
			p category
			radar_search_by_cat(lat=12.906131, long=77.586965, radius=800, category)
		end
	end

	def radar_search_by_cat(lat=12.906131, long=77.586965, radius=800, cat='food')
		#@client = GooglePlaces::Client.new('')
		p cat
		spots = @client.spots_by_radar(lat,long, :types => cat, :radius=> radius)
		p spots.count
		#spote = spots[3..-1]
		#p spote
		if spots.count > 0
			spots.each do |spot|
				p "******************start of insert******************"
				p spot.inspect
				r = RadarSearch.new
				r.lat = spot.lat
				r.long = spot.lng
				r.g_id = spot.id
				r.place_id = spot.place_id
				r.save
				p "******************end of insert******************"
			end		
		end
	end

	def radar_search_restaurants(lat=12.906131, long=77.586965, radius=800)
		#@client = GooglePlaces::Client.new('')
		spots = @client.spots(12.906131,77.586965, :type=> 'restaurant', :radius=>100)
	end

	def radar_search_cat(lat=12.906131, long=77.586965, radius=800, cat)
		#@client = GooglePlaces::Client.new('')
		spots = @client.spots(12.906131,77.586965, :type=> cat, :radius=>100)
	end

	def resolve_places(min_id=594, batch_size=800)
		p min_id
		radars = RadarSearch.where("id > ? and id < ",min_id.to_i, min_id.to_i+batch_size.to_i)
		radars.each do |radar|
			find_place(radar.place_id)
			p radar.place_id
		end		
	end

	def find_p(place_id)
		spot = @client.spot(place_id)
	end

	def find_place(place_id)
		spot = @client.spot(place_id)
		p = Place.new
		p.name = spot.name || ""
		p.address = spot.formatted_address || ""
		p.phone_no = spot.international_phone_number || ""
		p.lat = spot.lat
		p.long = spot.lng
		
		ac = spot.address_components
		len = ac.length
		p len
		p ac
		for i in 0..len-1
			p i
			type = ac[i]["types"][0]

			case type
			when "street_number"
				p.street_no = ac[i]["long_name"]
			when "route"
				p.route = ac[i]["long_name"]
			when "neighborhood"
				p.nb = ac[i]["long_name"]
			when "sublocality_level_1"
				p.sl_1 = ac[i]["long_name"]
			when "locality"
				p.locality = ac[i]["long_name"]
			when "sublocality_level_2"
				p.sl_2 = ac[i]["long_name"]
			when "sublocality_level_3"
				p.sl_3 = ac[i]["long_name"]
			when "administrative_area_level_1"
				p.aal_1 = ac[i]["long_name"]
			when "administrative_area_level_2"
				p.aal_2 = ac[i]["long_name"]
			when "country"
				p.country = ac[i]["long_name"]
			when "postal_code"
				p.pincode = ac[i]["long_name"]
			end
		end
		#p.street_no = spot.street_number || ""
		#p.route = spot.street || ""
		p.place_id = spot.place_id
		p.types = spot["types"].map{ |i|  %Q('#{i}') }.join(',')

		photos = spot.photos.count
		p photos
		if photos && photos>0
			for k in 0..photos-1
				pho = spot.photos[k]
				p pho
				oto = Photo.new
				p_url = Photo.photo_url(pho.width, pho.height, pho.photo_reference, pho.html_attributions)
				oto.url = p_url
				oto.place_id = spot.place_id
				oto.attribution = pho.html_attributions
				oto.photo_reference = pho.photo_reference
				oto.save
			end			
		end
		#p.photoreference = spot.photos

		p.save

		#name address  phone_no lat:decimal long:decimal street_no route nb sl_3 sl_2 sl_1 
		#locality aal_2 aal_1 country pincode place_id types photoreference 		
	end

	def place_mapping
		radars = RadarSearch.all
		radars.each do |radar|
			place = @client.find(radar.place_id)

		end
	end
end