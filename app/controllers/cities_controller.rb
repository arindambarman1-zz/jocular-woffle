class CitiesController < ApplicationController

  layout false

  def index
    @cities = City.order(:id)
  end
end
