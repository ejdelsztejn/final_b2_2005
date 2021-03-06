require 'rails_helper'

RSpec.describe 'Flight Show Page' do
  describe 'As a Visitor' do
    before :each do
      @airline = Airline.create!(name: "JetBlue")
      @flight_1 = @airline.flights.create!(number: "124", date: "8/3/2020", time: "1:15 PM EST", departure_city: "New York City - JFK", arrival_city: "Boston - Logan Airport")
      @jimmy = Passenger.create!(name: "Jimmy Lucia", age: 12)
      @margo = Passenger.create!(name: "Margo Santander", age: 32)
      @franco = Passenger.create!(name: "Franco Plants", age: 56)
      @moses = Passenger.create!(name: "Moses Adelson", age: 2)
      @abigail = Passenger.create!(name: "Abigail Weis", age: 90)
      @amos = Passenger.create!(name: "Amos Krayem", age: 21)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @jimmy.id)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @margo.id)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @franco.id)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @moses.id)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @abigail.id)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @amos.id)
    end

    it 'I see all of that flights information including: number, date, time, departure city, arrival city' do
      visit "/flights/#{@flight_1.id}"

      expect(page).to have_content(@flight_1.number)
      expect(page).to have_content(@flight_1.date)
      expect(page).to have_content(@flight_1.time)
      expect(page).to have_content(@flight_1.departure_city)
      expect(page).to have_content(@flight_1.arrival_city)
    end

    it 'I see the name of the airline this flight belongs to and I see the names of all of the passengers on this flight' do
      visit "/flights/#{@flight_1.id}"

      expect(page).to have_content(@airline.name)
      expect(page).to have_content(@jimmy.name)
      expect(page).to have_content(@margo.name)
      expect(page).to have_content(@franco.name)
      expect(page).to have_content(@moses.name)
      expect(page).to have_content(@abigail.name)
      expect(page).to have_content(@amos.name)
    end

    it 'I see the number of minors and adults on the flight' do
      visit "/flights/#{@flight_1.id}"
      save_and_open_page
      expect(page).to have_content("Number of minors: 2")
      expect(page).to have_content("Number of adults: 4")
    end
  end
end
