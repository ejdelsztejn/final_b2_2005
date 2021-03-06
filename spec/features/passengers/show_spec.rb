require 'rails_helper'

RSpec.describe 'Passenger Show Page' do
  describe 'As a Visitor' do
    before :each do
      @airline = Airline.create!(name: "JetBlue")
      @flight_1 = @airline.flights.create!(number: "124", date: "8/3/2020", time: "1:15 PM EST", departure_city: "New York City - JFK", arrival_city: "Boston - Logan Airport")
      @flight_2 = @airline.flights.create!(number: "564", date: "1/3/2020", time: "2:45 AM EST", departure_city: "New York City - JFK", arrival_city: "Denver International Airport")
      @flight_3 = @airline.flights.create!(number: "778", date: "1/23/2020", time: "10:15 PM MST", departure_city: "Denver International Airport", arrival_city: "New York City - JFK")
      @margo = Passenger.create!(name: "Margo Santander", age: 32)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @margo.id)
      FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @margo.id)
      FlightPassenger.create!(flight_id: @flight_3.id, passenger_id: @margo.id)
    end

    describe 'When I visit a passengers show page' do
      it 'I see that passengers name' do
        visit "/passengers/#{@margo.id}"

        expect(page).to have_content(@margo.name)
      end

      it 'I see a section of the page that displays all flight numbers of the flights for that passenger, and flight numbers are links to that flight’s show page' do
        visit "/passengers/#{@margo.id}"

        expect(page).to have_link(@flight_1.number)
        expect(page).to have_link(@flight_2.number)
        expect(page).to have_link(@flight_3.number)

        click_on "#{@flight_1.number}"
        expect(current_path).to eq("/flights/#{@flight_1.id}")
      end

      it "I see a form to add a flight. When I fill in the form with a flight number,
          And click submit, I'm taken back to the passengers show page
          And I can see the flight number of the flight I just added" do
        flight_4 = @airline.flights.create!(number: "891", date: "8/18/2020", time: "6:00 PM EST", departure_city: "Boston - Logan Airport", arrival_city: "New York City - JFK")

        visit "/passengers/#{@margo.id}"

        expect(page).to have_content("Add a New Flight")

        fill_in "Flight number", with: "891"

        click_on "Submit"

        expect(current_path).to eq("/passengers/#{@margo.id}")
        expect(page).to have_link(flight_4.number)
      end
    end
  end
end
