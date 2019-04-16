class SpecificProductRule
  def initialize(product, required_number, discount_price)
    @product = product
    @required_number = required_number
    @discount_price = discount_price
  end

  def discount_value(list_products)
    matched_products_number = list_products.select{ |pro| pro.code == @product.code }.size
    matched_products_number < @required_number ? 0 : (@product.price - @discount_price) * matched_products_number
  end
end