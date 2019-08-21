require 'rails_helper'

RSpec.describe 'Vehicles', type: :request do
  # Test suite for GET /vehicles/:id
  describe 'GET /vehicles/:id' do
    let!(:vehicle) {Vehicle.create(id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")}
    let!(:location) {Location.create(lat: 52.532, lng: 13.404, vehicle_id: "62b51cfe-0f5a-4f00-bb6f-215bb05d9520")}
    it 'returns status code 200' do
      get vehicle_path(vehicle)
      expect(response).to have_http_status(200)
    end

    it 'returns the data as JSON-Object' do
      get vehicle_path(vehicle)
      result = JSON(response.body)
      #binding.pry
      expect(result).to be_a_kind_of(Hash)
    end

    it 'response body should contain one location-record' do
      Location.create(lat: 52.5332, lng: 13.4014, vehicle: vehicle)
      get vehicle_path(vehicle)
      result = JSON(response.body)
      # push location record into array
      arr = []
      arr << result
      expect(arr.size).to eq(1)
    end

    it 'should contain a latitude and longitude' do
      get vehicle_path(vehicle)
      result = JSON(response.body)
      expect(result["lat"]).to eq(location.lat)
      expect(result["lng"]).to eq(location.lng)
    end
  end

  # Test suite for POST /vehicles
  describe 'POST /vehicles' do
    # upon creation, number of records in Vehicle table should be incremented by 1
    it 'creates a new vehicle' do
      size_one = Vehicle.count
      post vehicles_path(id: "2d931510-d99f-494a-8c67-87feb05e1598")
      size_two = Vehicle.count
      expect(size_two).to eq(size_one + 1)
    end

    # response status should be 204
    it 'returns status code 204' do
      post vehicles_path(id: "2d931510-d99f-494a-8c67-87feb05e1598")
      expect(response).to have_http_status(204)
    end
  end

  # Test suite for DELETE /vehicles/:id
  describe 'DELETE /vehicles/:id' do
    # should decrease the number of records in the Vehicle table by 1
    it 'should delete a vehicle' do
      # create Vehicle instance
      vehicle = Vehicle.create(id: "2d931510-d99f-494a-8c67-87feb05e1563")
      # store number of records in var
      size_before_delete = Vehicle.count
      # execute delete request
      delete "#{vehicles_path}/2d931510-d99f-494a-8c67-87feb05e1563"
      size_after_delete = Vehicle.count
      # store number of records in var and compare => size2 should be size1 - 1
      expect(size_after_delete).to eq(size_before_delete - 1)
    end

    # response status should be 204
    it 'returns status code 204' do
      vehicle = Vehicle.create(id: "2d931510-d99f-494a-8c67-87feb05e1563")
      delete "#{vehicles_path}/2d931510-d99f-494a-8c67-87feb05e1563"
      expect(response).to have_http_status(204)
    end
  end
end
