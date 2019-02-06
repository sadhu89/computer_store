# frozen_string_literal: true

class Product
  attr_reader :sku, :name, :price

  def initialize(sku:, name:, price:)
    @sku = sku
    @name = name
    @price = price
  end
end
