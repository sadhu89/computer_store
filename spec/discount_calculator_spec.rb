# frozen_string_literal: true

require 'discount_calculator'
require 'pricing_rule'
require 'discount'
require 'bigdecimal'

describe DiscountCalculator do
  subject(:calculator) { described_class.new(pricing_rules) }

  let(:pricing_rules) { [rule_1] }
  let(:rule_1) do
    instance_double(
      PricingRule,
      required_products: [mbp, vga],
      group_size: 1,
      minimum: 1,
      discount: discount
    )
  end
  let(:mbp) do
    double(
      'Product',
      price: BigDecimal.new('1399.99')
    )
  end
  let(:vga) do
    double(
      'Product',
      price: BigDecimal.new('30.0')
    )
  end
  let(:discount) do
    instance_double(
      Discount,
      product: vga,
      is_percentage: true,
      amount: 1.00,
      calculate: BigDecimal.new('-30.00')
    )
  end

  let(:items) { [mbp_line_item, vga_line_item] }
  let(:mbp_line_item) { double('LineItem', product: mbp, quantity: 1)}
  let(:vga_line_item) { double('LineItem', product: vga, quantity: 1)}

  describe 'calculate' do
    subject { calculator.calculate(items) }

    it { is_expected.to eq BigDecimal('-30.00') }
  end
end
