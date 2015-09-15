class Grid

	def linspace(init, final, num)
		increment = (final - init)/(num-1)
		spaces ||= []
		i = 0
		while i < num do
			point = init + (increment*i)
			spaces << point.round(6)
			i += 1
		end
		return spaces
	end


	def create_grid(lat_min, lat_max, long_min, long_max)
		x = linspace(lat_min, lat_max, 10)
		y = linspace(long_min, long_max, 10)
		coord = x.product(y)
		return coord
	end
end