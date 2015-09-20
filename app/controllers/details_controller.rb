class DetailsController < ApplicationController
  def index
  end

  def show
    @map = Detail.locations(params[:id])
    @hip_places = Detail.places_to_be(params[:id])
    @hip_cats = Detail.highest_checkin_cats(params[:id])
    @active_cats = Detail.most_active_cats(params[:id])
  end

  def json_locations
    map = Detail.locations(params[:id])
    render json: map
  end

  def json_top_places
    hip_places = Detail.places_to_be(params[:id])
    render json: hip_places
  end

  def json_top_cats
    hip_cats = Detail.highest_checkin_cats(params[:id])
    render json: hip_cats
  end

  def json_active_cats
    active_cats = Detail.most_active_cats(params[:id])
    render json: active_cats
  end
end
