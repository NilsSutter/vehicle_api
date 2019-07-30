class Api::V1::VehiclesController < ApplicationController
  before_action :find_vehicle, only: [ :show, :destroy ]

  def show
    # get latest location
    current_location = @vehicle.locations.order(id: :desc).first
    render json: current_location
  end

  def create
    # create new Vehicle instance. ID is set by request body
    @vehicle = Vehicle.new(id: params[:id])
    if @vehicle.save
      # respond with empty body
      head :no_content
    else
      render_error
    end
  end

  def destroy
    # @vehicle found with callback
    @vehicle.destroy
    # respond with empty body
    head :no_content
  end

  private
  def find_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
