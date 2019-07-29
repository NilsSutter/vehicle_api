class Api::V1::LocationsController < ApplicationController
  def create
    # find vehicle the location belongs to
    @vehicle = Vehicle.find(params[:vehicle_id])
    @location = Location.new(lat: params[:lat], lng: params[:lng]) #refactor later with strong_params
    @location.vehicle = @vehicle
    if @location.save
      head :no_content
    else
      render_error
    end
  end
end
