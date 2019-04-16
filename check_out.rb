require './specific_product_rule'
require './total_price_rule'
require './product'

class CheckOut
  attr_reader :total

  def initialize(rules)
    @original_amount = 0
    @total = 0
    @specific_product_rules = []
    @total_price_rules = []
    @products = []

    rules.each do |rule|
      if rule.is_a?(SpecificProductRule)
        @specific_product_rules << rule
      elsif rule.is_a?(TotalPriceRule)
        @total_price_rules << rule
      end
    end
  end

  def scan(product)
    @products << product
    @original_amount += product.price
    @total = @original_amount

    apply_specific_product_rule
    apply_total_price_rule
  end

  private

  def apply_specific_product_rule
    @specific_product_rules.each do |rule|
      @total -= rule.discount_value(@products)
    end
  end

  def apply_total_price_rule
    @total_price_rules.each do |rule|
      @total -= rule.discount_value(@total)
    end
  end
end