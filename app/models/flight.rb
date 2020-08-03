class Flight < ApplicationRecord
  validates_presence_of :number, :date, :time, :departure_city, :arrival_city
  validates_uniqueness_of :number, message: "This flight already exists"
  belongs_to :airline
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  def minors
    passengers.where(age: 0...18).count
  end

  def adults
    passengers.where(age: 18..Float::INFINITY).count
  end
end
