class Function

	def get_grid()
		grid = Grid.new
		min_lat = 12.773509
		max_lat = 13.162649
		min_long = 77.391904
		max_long = 77.803226
		coords = grid.create_grid(min_lat, max_lat, min_long, max_long)
		@i = 0
		payload = {'type': 'place', 'distance': '3000', 'limit': 500}
		payload_business = {"fields": "checkins,were_here_count"}
		j = 0
		coords.each do |coord|
			print("Trying to Gather places for Coordinate Pair #{j+1}\n")
			payload['center'] = coord.join(",")
			feed = FB.graph_call('search',args=payload)
			# Check for empty next_page
			k = 0
			while feed.size != 0 do
				feed.each do |f|
					business_id = f["id"]
					business_name = f["name"]
					cat_name = f["category_list"][0]["name"]
					latitude = f["location"]["latitude"]
					longitude = f["location"]["longitude"]

					# Make another call to collect object details
					details = FB.get_object(f['id'], args = payload_business)
					
					checkins = details["checkins"]
					@place = Place.new(business_id: business_id, business_name: business_name, cat_name: cat_name,
					latitude: latitude, longitude: longitude, checkins: checkins)
					@place.save
					@i += 1
					k += 1
				end
				feed = feed.next_page
			end
			print("Found #{k} places for Coordinate Pair #{j+1}\n")
			j += 1
		end
		print ("Found #@i places in Bangalore\n")
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