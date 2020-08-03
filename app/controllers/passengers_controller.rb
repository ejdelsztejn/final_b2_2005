class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:id])
  end

  def update
    passenger = Passenger.find(params[:id])
    flight = Flight.where({number: params[:flight_number].to_i}).first
    FlightPassenger.create(flight_id: flight.id, passenger_id: passenger.id)
    redirect_to "/passengers/#{passenger.id}"
  end
end
