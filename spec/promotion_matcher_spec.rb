# frozen_string_literal: true

require 'promotion_matcher'
require 'pricing_rule'
require 'line_item'
require 'product'

describe PromotionMatcher do
  subject(:matcher) { described_class.new(pricing_rule) }

  let(:pricing_rule) do
    instance_double(
      PricingRule,
      required_products: required_products,
      minimum: minimum,
      group_size: group_size,
    )
  end
  let(:group_size) { 1 }
  let(:minimum) { 0 }
  let(:required_products) { [product] }
  let(:product) { instance_double(Product) }
  let(:line_items) { [line_item] }
  let(:line_item) { instance_double(LineItem, product: product, quantity: 12) }

  describe '#matching_count' do
    subject { matcher.matching_count(line_items) }

    context 'with no items' do
      let(:line_items) { [] }

      it { is_expected.to eq 0 }
    end

    context 'with a group size condition' do
      let(:group_size) { 3 }

      it { is_expected.to eq 4 }
    end

    context 'with a minimum condition' do
      context 'when it is greater than the minimum' do
        let(:minimum) { 11 }

        it { is_expected.to eq 12 }
      end

      context 'when it is lower than the minimum' do
        let(:minimum) { 13 }

        it { is_expected.to eq 0 }
      end
    end

    context 'with a multiple product condition' do
      let(:required_products) { [product, other_product] }
      let(:other_product) { instance_double(Product) }
      let(:line_items) { [line_item, other_line_item] }
      let(:line_item) { instance_double(LineItem, product: product, quantity: 12) }
      let(:other_line_item) { instance_double(LineItem, product: product, quantity: 6) }

      it { is_expected.to eq 6 }
    end
  end
end
