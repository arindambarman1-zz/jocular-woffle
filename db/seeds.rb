# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
City.create(name: 'Bangalore', min_lat: '12.773509',
            max_lat: '13.162649', min_long: '77.391904',
            max_long: '77.803226')

City.create(name: 'Mumbai', min_lat: '18.891356',
            max_lat: '19.178820', min_long: '72.778564',
            max_long: '72.980138')

City.create(name: 'Delhi', min_lat: '28.411976',
            max_lat: '28.889211', min_long: '76.840132',
            max_long: '77.333143')

City.create(name: 'Kolkata', min_lat: '22.349050',
            max_lat: '23.006679', min_long: '88.194866',
            max_long: '88.539562')

City.create(name: 'Chennai', min_lat: '12.837097',
            max_lat: '13.258911', min_long: '80.105891',
            max_long: '80.305675')
