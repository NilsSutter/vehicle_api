class Api::V1::LocationsController < ApplicationController
  def create
    # find vehicle the location belongs to
    @vehicle = Vehicle.find(params[:vehicle_id])
    @location = Location.new(lat: params[:lat], lng: params[:lng]) #refactor later with strong_params
    @location.vehicle = @vehicle
    # check if distance < 3.5km
    distance_to_door2door <= 3.5 ? save_location : @vehicle.locations.delete_all
  end

  private
  def distance_to_door2door
    door2door_office = [52.53, 13.403] #[lat, lng]
    @location.distance_to(door2door_office).round(2)
  end

  def save_location
    if @location.save
      head :no_content
    else
      render_error
    end
  end
end
