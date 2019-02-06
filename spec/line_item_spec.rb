# frozen_string_literal: true

require 'line_item'
require 'product'

describe LineItem do
  subject(:line_item) { described_class.new(product) }
  let(:product) { instance_double(Product, price: 50) }

  describe '#price' do
    subject { line_item.price }

    it { is_expected.to eq 50 }
  end

  describe 'increase_quantity' do
    specify do
      line_item.increase_quantity(3)
      expect(line_item.price).to eq 200
    end
  end
end
