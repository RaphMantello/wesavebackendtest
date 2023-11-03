require 'json'
require 'date'

require '../commission'
require '../rental'
require '../action'

data_file = File.read('./data/input.json')
data = JSON.parse(data_file)
RENTALS_INPUTS = data['rentals']
CARS = data['cars']
OPTIONS = data['options']
ACTOR_TYPES = %w[driver owner insurance assistance drivy].freeze

output = {
  rentals:
  RENTALS_INPUTS.map do |input|
    rental = Rental.new(input)
    {
      id: rental.id,
      options: rental.options,
      actions: rental.actions
    }
  end
}

File.write('./data/output.json', JSON.dump(output))
