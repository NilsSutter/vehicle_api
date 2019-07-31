require 'rails_helper'

RSpec.describe 'Vehicles', type: :request do
  # Test suite for GET /vehicles/:id
  describe 'GET /vehicles/:id' do
    it 'returns status code 200' do
      vehicle = Vehicle.create(id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      get vehicle_path(vehicle)
      expect(response).to have_http_status(200)
    end

    it 'returns json' do
      vehicle = Vehicle.create(id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      location = Location.create(lat: 52.532, lng: 13.404, vehicle_id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      get vehicle_path(vehicle)
      result = JSON(response.body)
      #binding.pry
      expect(result.length).to eq(1)
    end
  end
end
