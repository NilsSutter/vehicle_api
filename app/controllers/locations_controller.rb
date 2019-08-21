class LocationsController < ApplicationController
  DEFAULT_DISTANCE = 0.5
  def create
    # find vehicle the location belongs to
    @vehicle = Vehicle.find(params[:vehicle_id])
    @location = Location.new(lat: params[:lat], lng: params[:lng])
    @location.vehicle = @vehicle
    # check if distance < 3.5km and delete location, if vehicle is more than 3.5km from the office
    validate_within_distance(ENV["DISTANCE"].to_f || DEFAULT_DISTANCE)
  end

  private
  def validate_within_distance(distance)
    distance_to_door2door <= distance ? save_location : @location.delete
  end

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
