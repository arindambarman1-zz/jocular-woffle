class Analysis
  # Method for getting the location points for mapping
  def map_location(location)
    city_id = City.where('name = ?', location).pluck(:id)
    Business.select('business_id', 'latitude',
                    'longitude').where('city_id = ?', city_id)
  end

  # Method for getting the top destinations in each city
  # Use eager loading to overcome the N+1 query problem
  def top16_destinations(location)
    city_id = City.where('name = ?', location).pluck(:id)
    hip_places = Business.includes(:checkin).where(
      'city_id = ?', city_id).order('checkins.checkins DESC').limit(16)
    print "The top 16 destinations in #{location} are:\n"
    hip_places.each do |place|
      print "#{place.business_name} with #{place.checkin.checkins} checkins\n"
    end
  end
end
