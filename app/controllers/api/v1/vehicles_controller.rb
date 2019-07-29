class Api::V1::VehiclesController < ApplicationController
  def create
    @vehicle = Vehicle.new
    if @vehicle.save
      # respond with empty body
      head :no_content
    else
      render_error
    end
  end

  def destroy
    # find vehicle with id
    @vehicle = Vehicle.find(params[:id])
    # destroy vehicle
    @vehicle.destroy
    # respond with empty body
    head :no_content
  end
end
