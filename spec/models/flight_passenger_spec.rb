require 'rails_helper'

describe FlightPassenger, type: :model do
  describe 'validations' do
    it { should belong_to :flight }
    it { should belong_to :passenger }
  end
end
