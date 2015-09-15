class Checkins
	def get_checkins
		payload_business = {"fields": "checkins"}
		Place.select("id","business_id").find_in_batches(batch_size: 50) do |places|
			results = FB.batch do |batch_api|
				begin
					for place in places do
						batch_api.get_object(place['business_id'].to_s, args = payload_business)
					end
				rescue Faraday::ConnectionFailed
					sleep 5
					batch_api.get_object(place['business_id'].to_s, args = payload_business)
				end
			end
			results.each do |result|
				enter_into_checkin(result)
			end
		end
	end

	def enter_into_checkin(result)
		business_id = result["id"]
		checkins = result["checkins"]
		begin
			@checkin = Checkin.new(business_id: business_id, checkins: checkins)
			@checkin.save
		rescue PG::UniqueViolation
			print("Error Inserting to DB")
		end
	end
end