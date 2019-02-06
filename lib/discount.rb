# frozen_string_literal: true

class Discount
  attr_reader :product, :amount, :is_percentage

  def initialize(product:, amount:, is_percentage:)
    @product = product
    @amount = amount
    @is_percentage = is_percentage
  end

  def calculate
    if is_percentage
      @product.price * amount
    else
      amount
    end
  end
end
