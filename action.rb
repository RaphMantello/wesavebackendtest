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
    rental.total_price
  end

  def insurance_amount
    commission.insurance_fee
  end

  def assistance_amount
    commission.assistance_fee
  end

  def drivy_amount
    commission.drivy_fee
  end

  def owner_amount
    rental.total_price - commission.value
  end
end
