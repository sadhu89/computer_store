# frozen_string_literal: true

require 'line_item'

class Order
  attr_reader :line_items

  def initialize
    @line_items = []
  end

  def add_product(product)
    line_item = @line_items.find { |line_item| line_item.product.sku == product.sku}
    if line_item
      line_item.increase_quantity
    else
      @line_items << LineItem.new(product)
    end
  end
end
