require 'rails_helper'

RSpec.describe FeeCalculator, :type => :model do
  let(:calculator) { FeeCalculator.new(attr) }
  describe '#hour_fee' do
    subject { calculator.hour_fee(datetime) }
    let(:datetime) { DateTime.now }

    context '30分200円の時' do
      let(:attr) do
        {
         'type' => 'basic',
         'per_minute' => 30,
         'fee' => 200,
        }
      end

      it { is_expected.to eq(400) }
    end

    context '30分200円最大300円の時' do
      let(:attr) do
        {
         'type' => 'basic',
         'per_minute' => 30,
         'fee' => 200,
         'max' => 300,
        }
      end

      it { is_expected.to eq(300) }
    end
  end
end
