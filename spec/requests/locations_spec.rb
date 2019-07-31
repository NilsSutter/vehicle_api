require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  #Test suite for POST /vehicles/:id/locations
  describe 'POST /vehicles/:id/locations' do
    context 'when coordinates within door2door-radius' do
      it 'creates a new location' do
        # create 1 vehicle instance
        size_before = Location.count
        vehicle = Vehicle.create(id: "2d931510-d99f-494a-8c67-87feb05e1598")
        # give it one location instance within radius
        post vehicle_locations_path(vehicle, lat: 52.532, lng: 13.404)
        size_after = Location.count
        expect(size_after).to eq(size_before + 1)
      end

      # response status should be 204
      it 'returns status code 204' do
        vehicle = Vehicle.create(id: "2d931510-d99f-494a-8c67-87feb05e1598")
        # give it one location instance within radius
        post vehicle_locations_path(vehicle, lat: 52.532, lng: 13.404)
        expect(response).to have_http_status(204)
      end
    end
    context 'when coordinates not within door2door-radius' do
      it 'creates no location' do
        # create 1 vehicle instance
        size_before = Location.count
        vehicle = Vehicle.create(id: "2d931510-d99f-494a-8c67-87feb05e1598")
        # give it one location instance out of radius
        post vehicle_locations_path(vehicle, lat: 60.532, lng: 10.404)
        size_after = Location.count
        expect(size_after).to eq(size_before)
        # create another location instance within radius via request URI
        # @vehicle.locations.count (=2) in var
      end

      # response status should be 204
      it 'returns status code 204' do
        vehicle = Vehicle.create(id: "2d931510-d99f-494a-8c67-87feb05e1598")
        # give it one location instance out of radius
        post vehicle_locations_path(vehicle, lat: 60.532, lng: 10.404)
        expect(response).to have_http_status(204)
      end
    end
  end
end
