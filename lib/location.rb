class Location
  def create_grid(name)
    grid = Grid.new
    city = City.find_by name: name
    min_lat = city['min_lat'].to_f
    max_lat = city['max_lat'].to_f
    min_long = city['min_long'].to_f
    max_long = city['max_long'].to_f
    city_id = city['id']
    coords = grid.create_grid(min_lat, max_lat, min_long, max_long)
    payload = { 'type': 'place', 'distance': '3000', 'limit': 500 }
    j = 0
    coords.each do |coord|
      Retryable.retryable(
        tries: 10,
        on: Faraday::ConnectionFailed,
        sleep: ->(n) { 4**n }
      ) do
        print "#{city['name']} places for Coordinate Pair #{j + 1}\n"
        payload['center'] = coord.join(',')
        feed = FB.graph_call('search', payload)
        enter_into_db(feed, city_id)
      end
      j += 1
    end
  end

  def collect_all_places
    City.find_each do |city|
      create_grid(city['name'])
    end
  end

  def enter_into_db(feed, city_id)
    k = 0
    while feed.size != 0
      feed.each do |f|
        business_id = f['id']
        business_name = f['name']
        cat_name = f['category_list'][0]['name']
        latitude = f['location']['latitude']
        longitude = f['location']['longitude']
        begin
          @place = Business.new(business_id: business_id, business_name:
                                business_name, cat_name: cat_name,
                                latitude: latitude, longitude: longitude,
                                city_id: city_id)
          @place.save
          k += 1
        rescue ActiveRecord::RecordNotUnique
          next
        end
      end
      feed = feed.next_page
    end
    print("Found #{k} places\n")
  end
end
