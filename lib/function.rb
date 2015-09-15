class Function

	def get_grid(name)
		grid = Grid.new
		city = City.find_by name: name
		min_lat = city['min_lat'].to_f
		max_lat = city['max_lat'].to_f
		min_long = city['min_long'].to_f
		max_long = city['max_long'].to_f
		city_id = city['id']
		coords = grid.create_grid(min_lat, max_lat, min_long, max_long)
		payload = {'type': 'place', 'distance': '3000', 'limit': 500}
		payload_business = {"fields": "checkins,were_here_count"}
		j = 0
		coords.each do |coord|
			begin
				print("Trying to Gather places for Coordinate Pair #{j+1} for #{city['name']}\n")
				payload['center'] = coord.join(",")
				feed = FB.graph_call('search',args=payload)
				enter_into_db(feed, city_id)
			rescue Faraday::ConnectionFailed
				sleep 5
				print "Error Handling for Coordinate Pair #{j+1}\n"
				feed = FB.graph_call('search',args=payload)
				enter_into_db(feed, city_id)
			end
			j += 1
		end
	end


	
	def get_all_places
		City.find_each do |city|
			get_grid(city["name"])
		end
	end


	def enter_into_db(feed, city_id)
		k = 0
		while feed.size != 0 do
			feed.each do |f|
				business_id = f["id"]
				business_name = f["name"]
				cat_name = f["category_list"][0]["name"]
				latitude = f["location"]["latitude"]
				longitude = f["location"]["longitude"]

				begin
					@place = Place.new(business_id: business_id, business_name: business_name, cat_name: cat_name,
					latitude: latitude, longitude: longitude, city_id: city_id)
					@place.save
				rescue ActiveRecord::RecordNotUnique
					next
				end
				k += 1
			end
			feed = feed.next_page
		end
		print("Found #{k} places for Coordinate Pair\n")
	end
end


__END__
Try for batch ** something like this?? **
feed = FB.batch do |batch_api|
				batch_api.graph_call('search',args=payload)
				while feed.each.size != 0 do
					feed.each do |f|
						business_id = f["id"]
						business_name = f["name"]
						cat_name = f["category_list"][0]["name"]
						latitude = f["location"]["latitude"]
						longitude = f["location"]["longitude"]

						details = FB.get_object(f['id'], args = payload_business)
				
						checkins = details["checkins"]
					end
					feed = feed.next_page