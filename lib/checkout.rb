# frozen_string_literal: true

require 'discount_calculator'
require 'order'

class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @order = Order.new
  end

  def total
    @order.line_items.map(&:price).sum - discount
  end

  def scan(product)
    @order.add_product(product)
  end

  private

  def discount
    DiscountCalculator.new(@pricing_rules).calculate(@order.line_items)
  end
end
