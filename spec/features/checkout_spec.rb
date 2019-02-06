# frozen_string_literal: true

require 'checkout'
require 'discount_calculator'
require 'bigdecimal'

describe 'Checkout' do
  subject(:checkout) {Checkout.new(pricing_rules) }
  let(:ipd) do
    Product.new(
      sku: 'ipd',
      name: 'Super Ipad',
      price: BigDecimal.new('549.99')
    )
  end
  let(:mbp) do
    Product.new(
      sku: 'mbp',
      name: 'MacBook Pro',
      price: BigDecimal.new('1399.99')
    )
  end
  let(:atv) do
    Product.new(
      sku: 'atv',
      name: 'Apple TV',
      price: BigDecimal.new('109.50')
    )
  end
  let(:vga) do
    Product.new(
      sku: 'vga',
      name: 'VGA adapter',
      price: BigDecimal.new('30.00')
    )
  end

  let(:pricing_rules) { [atv_3x2, ipd_bulk, free_vga] }

  let(:atv_3x2) do
    PricingRule.new(
      required_products: [atv],
      group_size: 3,
      minimum: nil,
      discount: Discount.new(
        product: atv,
        is_percentage: true,
        amount: 1
      )
    )
  end

  let(:ipd_bulk) do
    PricingRule.new(
      required_products: [ipd],
      group_size: nil,
      minimum: 4,
      discount: Discount.new(
        product: ipd,
        is_percentage: false,
        amount: 50
      )
    )
  end

  let(:free_vga) do
    PricingRule.new(
      required_products: [mbp, vga],
      group_size: nil,
      minimum: nil,
      discount: Discount.new(
        product: vga,
        is_percentage: true,
        amount: 1
      )
    )
  end

  describe 'success' do
    subject { checkout.total }
    context '3 x 2 apple TV' do
      specify do
        checkout.scan(atv)
        checkout.scan(atv)
        checkout.scan(atv)
        checkout.scan(vga)
        expect(checkout.total).to eq BigDecimal.new('249.00')
      end
    end

    context 'super ipad bulk' do
      specify do
        checkout.scan(atv)
        checkout.scan(ipd)
        checkout.scan(ipd)
        checkout.scan(atv)
        checkout.scan(ipd)
        checkout.scan(ipd)
        checkout.scan(ipd)
        expect(checkout.total).to eq BigDecimal.new('2718.95')
      end
    end

    context 'free vga' do
      specify do
        checkout.scan(mbp)
        checkout.scan(vga)
        checkout.scan(ipd)
        expect(checkout.total).to eq BigDecimal.new('1949.98')
      end
    end
  end
end
