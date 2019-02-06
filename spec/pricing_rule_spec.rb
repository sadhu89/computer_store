# frozen_string_literal: true

require 'pricing_rule'
require 'product'
require 'discount'

describe PricingRule do
  subject(:rule) do
    described_class.new(
      required_products: [product],
      group_size: group_size,
      minimum: minimum,
      discount: discount
    )
  end

  let(:product) { instance_double(Product) }
  let(:discount) { instance_double(Discount) }

  describe 'Sets default values for minimum and discount', :aggregate_failures do
    let(:minimum) { nil }
    let(:group_size) { nil }

    specify do
      expect(rule.minimum).to eq 0
      expect(rule.group_size).to eq 1
    end
  end
end
