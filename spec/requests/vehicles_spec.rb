require 'rails_helper'

RSpec.describe 'Vehicles', type: :request do
  # Test suite for GET /vehicles/:id
  describe 'GET /vehicles/:id' do
    it 'returns status code 200' do
      vehicle = Vehicle.create(id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      get vehicle_path(vehicle)
      expect(response).to have_http_status(200)
    end

    it 'returns the updated location as Hash' do
      vehicle = Vehicle.create(id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      location = Location.create(lat: 52.532, lng: 13.404, vehicle_id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      get vehicle_path(vehicle)
      result = JSON(response.body)
      expect(result).to be_a_kind_of(Hash)
    end

    it 'response body should contain one location-record' do
      vehicle = Vehicle.create(id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      location = Location.create(lat: 52.532, lng: 13.404, vehicle_id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      location = Location.create(lat: 52.5332, lng: 13.4014, vehicle_id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")
      get vehicle_path(vehicle)
      result = JSON(response.body)
      # push location record into array
      arr = []
      arr << result
      expect(arr.size).to eq(1)
    end
  end

  describe 'POST /vehicles' do
    # upon creation, Vehicle-table should contain one more record
    it 'creates a new vehicle' do
      Vehicle.create(id: "2d931510-d99f-494a-8c67-87feb05e1563")
      size_one = Vehicle.count
      post vehicles_path(id: "2d931510-d99f-494a-8c67-87feb05e1598")
      size_two = Vehicle.count
      expect(size_two).to eq(size_one + 1)
      # expect{ post(:create, params: {vehicle: params}) }.to change(Vehicle, :count).by(1)
    end
    # response status should be 204
    it 'returns status code 204' do
      post vehicles_path(id: "2d931510-d99f-494a-8c67-87feb05e1598")
      expect(response).to have_http_status(204)
    end
  end

  describe 'DELETE /vehicles/:id' do
  end
end
