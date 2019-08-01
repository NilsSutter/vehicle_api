# class Api::V1::LocationsController < ApplicationController
class LocationsController < ApplicationController
  def create
    # find vehicle the location belongs to
    @vehicle = Vehicle.find(params[:vehicle_id])
    @location = Location.new(lat: params[:lat], lng: params[:lng]) #refactor later with strong_params
    @location.vehicle = @vehicle
    # check if distance < 3.5km and delete location, if vehicle is more than 3.5km from the office
    distance_to_door2door <= 3.5 ? save_location : @location.delete
  end

  private
  def distance_to_door2door
    door2door_office = [52.53, 13.403] #[lat, lng]
    @location.distance_to(door2door_office).round(2)
  end

  def save_location
    if @location.save
      # transmit data to the location channel
      ActionCable.server.broadcast 'locations_channel',
        message: "latitude: #{@location.lat}, longitude: #{@location.lng}"
        # response body should be empty and status should be 204
      head :no_content
    else
      render_error
    end
  end

  def render_error
    render json: { errors: @location.errors.full_messages },
      status: :unprocessable_entity
  end
end
