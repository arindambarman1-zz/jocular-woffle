class AddCities
  def self.add_city
    @bangalore = City.new(name: 'Bangalore', min_lat: '12.773509',
                          max_lat: '13.162649', min_long: '77.391904',
                          max_long: '77.803226')
    @bangalore.save

    @mumbai = City.new(name: 'Mumbai', min_lat: '18.891356',
                       max_lat: '19.178820', min_long: '72.778564',
                       max_long: '72.980138')
    @mumbai.save

    @delhi = City.new(name: 'Delhi', min_lat: '28.411976',
                      max_lat: '28.889211', min_long: '76.840132',
                      max_long: '77.333143')
    @delhi.save

    @kolkata = City.new(name: 'Kolkata', min_lat: '22.349050',
                        max_lat: '23.006679', min_long: '88.194866',
                        max_long: '88.539562')
    @kolkata.save

    @chennai = City.new(name: 'Chennai', min_lat: '12.837097',
                        max_lat: '13.258911', min_long: '80.105891',
                        max_long: '80.305675')
    @chennai.save
  end
end
