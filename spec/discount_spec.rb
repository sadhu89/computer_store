# frozen_string_literal: true

require 'discount'
require 'product'

describe Discount do
  subject(:discount) do
    described_class.new(
      product: product,
      amount: 0.5,
      is_percentage: is_percentage
    )
  end

  let(:product) { instance_double(Product, price: 120) }

  describe '#calculate' do
    subject { discount.calculate  }

    context 'with a percentage' do
      let(:is_percentage) { true }

      it { is_expected.to eq 60 }
    end

    context 'with an amount' do
      let(:is_percentage) { false }

      it { is_expected.to eq 0.5 }
    end
  end
end
