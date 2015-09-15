require "#{Rails.root}/app/models/place"

class Checkins

	# Changed into a instance method
	# Bangalore = 12.9667, 77.5667
	def get_place(lat,long)
		@i = 0
		@coord = [lat,long].join(",")
		payload = {'type': 'place', 'center': @coord, 'distance': '3000', 'limit': 10}
		payload_business = {"fields": "checkins,were_here_count"}

		feed = FB.graph_call('search',args=payload)

		# Check for empty next_page
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
			end

			feed = feed.next_page
		end
		print ("Inserted #@i places")
	end
end