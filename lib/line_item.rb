# frozen_string_literal: true

class LineItem
  attr_reader :product, :quantity

  def initialize(product, quantity = 1)
    @product = product
    @quantity = quantity
  end

  def price
    @product.price * @quantity
  end

  def increase_quantity(units = 1)
    @quantity += units
  end
end
