require "#{Rails.root}/lib/analysis_module"
class Detail < ActiveRecord::Base
  include AnalysisModule

  @analysis = Analysis.new
  # Map Locations
  def self.locations(city_id)
    @analysis.map_location(city_id)
  end

  # Top Checkin Places
  def self.places_to_be(city_id)
    @analysis.top16_destinations(city_id)
  end

  # Highest Checkin Categoris
  def self.highest_checkin_cats(city_id)
    @analysis.top16_categories(city_id)
  end

  # Most Active Categories
  def self.most_active_cats(city_id)
    @analysis.highest_average_checkins(city_id)
  end
end
