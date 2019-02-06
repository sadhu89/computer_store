# frozen_string_literal: true

class PricingRule
  attr_reader :required_products, :group_size, :minimum, :discount
   def initialize(required_products:, group_size:, minimum:, discount:)
     @required_products = required_products
     @group_size = group_size || 1
     @minimum = minimum || 0
     @discount = discount
  end
end
