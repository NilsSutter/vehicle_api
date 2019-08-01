class LocationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "location_#{params[:vehicle_id]}"
  end
end
