require 'json'
require 'date'

data_file = File.read('./data/input.json')
data = JSON.parse(data_file)
RENTALS = data['rentals']
CARS = data['cars']

def find_car(id)
  CARS.select { |car| car['id'] == id }.first
end

def find_rental(id)
  RENTALS.select { |rental| rental['id'] == id }.first
end

def deduction_rate(day)
  if day < 1
    1
  elsif day < 4
    0.9
  elsif day < 10
    0.7
  else
    0.5
  end
end

def price_per_day(nb_days, car)
  total = 0
  nb_days.times do |i|
    total += (car['price_per_day'] * deduction_rate(i)).to_i
  end
  total
end

def rental_price(rental_id, car_id)
  car = find_car(car_id)
  rental = find_rental(rental_id)
  nb_days = (Date.parse(rental['end_date']) - Date.parse(rental['start_date'])).to_i + 1
  price_per_day(nb_days, car) + rental['distance'] * car['price_per_km']
end

output = {
  rentals:
  RENTALS.map do |rental|
    {
      id: rental['id'],
      price: rental_price(rental['id'], rental['car_id'])
    }
  end
}

File.write('./data/output.json', JSON.dump(output))
