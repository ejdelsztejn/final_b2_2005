class AddAirlineForeignKeyToFlights < ActiveRecord::Migration[5.1]
  def change
    add_reference :flights, :airline, index: true
  end
end
