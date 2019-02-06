# frozen_string_literal: true

require 'promotion_matcher'

class DiscountCalculator
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
  end

  def calculate(items)
    @pricing_rules.reduce(0) do |sum, pricing_rule|
      sum + discount(pricing_rule, items)
    end
  end

  private

  def discount(pricing_rule, items)
    PromotionMatcher.new(pricing_rule).matching_count(items) * pricing_rule.discount.calculate
  end
end
