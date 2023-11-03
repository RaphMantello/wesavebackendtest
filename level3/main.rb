require 'json'
require 'date'

require '../commission'
require '../rental'

data_file = File.read('./data/input.json')
data = JSON.parse(data_file)
RENTALS_INPUTS = data['rentals']
CARS = data['cars']

output = {
  rentals:
  RENTALS_INPUTS.map do |input|
    rental = Rental.new(input)
    {
      id: rental.id,
      price: rental.total_price,
      commission: Commission.new(rental).formatted
    }
  end
}

File.write('./data/output.json', JSON.dump(output))
