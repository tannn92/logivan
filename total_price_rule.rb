class TotalPriceRule
  def initialize(minimum_total_value, discount_percent)
    @minimum_total_value = minimum_total_value
    @discount_percent = discount_percent
  end

  def discount_value(total)
    total >= @minimum_total_value ? total * @discount_percent : 0
  end
end