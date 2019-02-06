# frozen_string_literal: true

class PromotionMatcher
  def initialize(pricing_rule)
    @pricing_rule = pricing_rule
  end

  def matching_count(line_items)
    return 0 unless valid?(line_items)
    matching_count_without_groupping(line_items) / @pricing_rule.group_size
  end

  private

  def valid?(line_items)
    matching_count_without_groupping(line_items) >= @pricing_rule.minimum
  end

  def matching_count_without_groupping(line_items)
    matching_line_items = line_items.select do |line_item|
      @pricing_rule.required_products.include?(line_item.product)
    end
    if matching_line_items&.count == @pricing_rule.required_products.count
      matching_line_items.map(&:quantity).min
    else
      0
    end
  end
end
