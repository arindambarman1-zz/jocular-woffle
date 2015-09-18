module AnalysisModule
  class Analysis

    # Method for getting the location points for mapping
    def map_location(city_id)
      Business.joins(:checkin).select(
        'business_id', 'latitude', 'longitude', 'checkins.checkins').where(
        'city_id = ?', city_id).references(:checkins)
    end

    # Method for getting the top destinations in each city
    def top16_destinations(city_id)
      Business.joins(:checkin).where('city_id = ?', city_id).select(
        'business_id', 'business_name', 'checkins.checkins as checkin_no').order(
          'checkins.checkins DESC').limit(16)
    end

    # Method for getting the top 16 categories in each city
    def top16_categories(city_id)
      Business.joins(:checkin).where(
        'city_id = ? AND checkins.checkins > ?', city_id, 0).select(
          'business_id', 'cat_name', 'count_cat_name as top_categories').group(
            'cat_name').order('count_cat_name DESC').limit(16).count('cat_name')
    end

    # Highest average check in categories
    # We can do better???
    def highest_average_checkins(city_id)
      Business.joins(:checkin).where(
        'city_id = ? AND checkins.checkins > ?', city_id, 0).select(
          'business_id', 'cat_name', 'average_checkins_checkins as avg_checkins').group(
            'cat_name').order('average_checkins_checkins DESC').limit(15).average(
              'checkins.checkins')
    end
  end
end
