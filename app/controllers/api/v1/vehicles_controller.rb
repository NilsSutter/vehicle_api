class Api::V1::VehiclesController < ApplicationController
  def create
    @vehicle = Vehicle.new

    if @vehicle.save
      head :no_content
    else
      render_error
    end
  end

  def destroy
  end
end
