class Commission
  attr_accessor :value, :duration

  def initialize(rental)
    @value = rental.total_price * 0.3
    @duration = rental.duration
  end

  def formatted
    {
      "insurance_fee": insurance_fee.to_i,
      "assistance_fee": assistance_fee.to_i,
      "drivy_fee": drivy_fee.to_i
    }
  end

  def insurance_fee
    value * 0.5
  end

  def assistance_fee
    100 * duration
  end

  def drivy_fee
    value - insurance_fee - assistance_fee
  end
end
