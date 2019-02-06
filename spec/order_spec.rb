# frozen_string_literal: true

require 'order'
require 'product'

describe Order do
  subject(:order) { described_class.new }

  let(:product) { instance_double(Product, sku: 'vga') }

  describe '#add_product' do
    context 'new product' do
      specify do
        order.add_product(product)
        expect(order.line_items.first.quantity).to eq(1)
        expect(order.line_items.first.product).to eq(product)
      end
    end
  end

  describe '#add_product' do
    context 'new product' do
      specify do
        order.add_product(product)
        order.add_product(product)
        expect(order.line_items.first.quantity).to eq(2)
        expect(order.line_items.first.product).to eq(product)
      end
    end
  end
end
