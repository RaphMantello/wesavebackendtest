class Rental
  attr_accessor :id, :car_id, :start_date, :end_date, :distance

  def initialize(input)
    @id = input['id']
    @car_id = input['car_id']
    @start_date = input['start_date']
    @end_date = input['end_date']
    @distance = input['distance']
  end

  def duration
    (Date.parse(end_date) - Date.parse(start_date)).to_i + 1
  end

  def total_price
    car = find_car(car_id)
    price_per_day(car) + distance * car['price_per_km']
  end

  def price_per_day(car)
    total = 0
    duration.times do |i|
      total += (car['price_per_day'] * deduction_rate(i)).to_i
    end
    total
  end

  def find_car(id)
    CARS.select { |car| car['id'] == id }.first
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
end
