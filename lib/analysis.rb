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

  # Method for getting the top 16 categories in each city
  def top16_categories(location)
    city_id = City.where('name = ?', location).pluck(:id)
    hip_cats = Business.joins(:checkin).where("city_id = ? AND checkins.checkins > ?", city_id,0).select(
      'cat_name', 'city_id', 'count_cat_name').group(
        'cat_name').order('count_cat_name DESC').limit(16).count('cat_name')
    print "The top 16 categories in #{location} are:\n"
    hip_cats.each do |cat|
      print cat
    end
  end

  # Highest average check in categories
  # We can do better???
  def highest_average_checkins(location)
    city_id = City.where('name = ?', location).pluck(:id)
    active_cats = Business.joins(:checkin).where('city_id = ? AND checkins.checkins > ?', city_id, 1).select(
      'business_id', 'average_checkins_checkins').group('cat_name').order(
        'average_checkins_checkins DESC').limit(15).average('checkins.checkins')
    print "Most active categories in #{location} are:\n"
    active_cats.each do |cat|
      print "#{cat[0]} #{cat[1]}\n"
    end
  end
end
