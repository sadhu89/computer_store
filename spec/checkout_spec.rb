# frozen_string_literal: true

require 'checkout'
require 'bigdecimal'
require 'pricing_rule'
require 'product'

describe Checkout do
  subject(:checkout) { described_class.new(pricing_rules) }

  let(:pricing_rules) { [ instance_double(PricingRule) ] }

  let(:super_ipad) { instance_double(Product, sku: 'spd', price: BigDecimal.new('549.99')) }
  let(:mac_book_pro) { instance_double(Product, sku: 'mbp', price: BigDecimal.new('1399.99')) }

  let(:discount_calculator) { instance_double(DiscountCalculator) }
  let(:order) { instance_double(Order) }
  let(:items) { [] }
  let(:discount) { 0 }

  before do
    expect(Order).to receive(:new).and_return(order)
    expect(order).to receive(:line_items).and_return(items).twice
    allow(order).to receive(:add_product).twice
    expect(DiscountCalculator).to receive(:new).with(pricing_rules).and_return(discount_calculator)
    expect(discount_calculator).to receive(:calculate).with(items).and_return(discount)
  end

  describe '#total' do
    subject(:total) { checkout.total }

    context 'with no items' do
      it { is_expected.to eq 0 }
    end

    context 'with multiple items' do
      let(:items) { [super_ipad, mac_book_pro] }

      specify do
        checkout.scan(super_ipad)
        checkout.scan(mac_book_pro)
        expect(total).to eq BigDecimal('1949.98')
      end
    end

    context 'with discount' do
       let(:items) { [super_ipad, mac_book_pro] }
      let(:discount) { 100 }

      specify do
        checkout.scan(super_ipad)
        checkout.scan(mac_book_pro)
        expect(total).to eq BigDecimal('1849.98')
      end
    end
  end

  describe '#scan' do
    let(:items) { [super_ipad] }

    specify do
      checkout.scan(super_ipad)
      expect(checkout.total).to eq BigDecimal('549.99')
    end
  end
end
