class Action
  attr_accessor :who, :type, :rental, :commission, :amount

  def initialize(who, rental)
    @who = who
    @type = who.to_s == 'driver' ? 'debit' : 'credit'
    @rental = rental
    @commission = Commission.new(rental)
    @amount = send("#{who}_amount")
  end

  def formatted
    {
      who: who,
      type: type,
      amount: amount.to_i
    }
  end

  def driver_amount
    rental.total_price + gps_option + baby_seat_option + insurance_option
  end

  def insurance_amount
    commission.insurance_fee
  end

  def assistance_amount
    commission.assistance_fee
  end

  def drivy_amount
    commission.drivy_fee + insurance_option
  end

  def owner_amount
    rental.total_price - commission.value + gps_option + baby_seat_option
  end

  def gps_option
    return 0 unless rental.options.include?('gps')

    rental.duration * 500
  end

  def baby_seat_option
    return 0 unless rental.options.include?('baby_seat')

    rental.duration * 200
  end

  def insurance_option
    return 0 unless rental.options.include?('additional_insurance')

    rental.duration * 1000
  end
end
