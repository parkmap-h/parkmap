require 'rails_helper'

RSpec.describe Park, :type => :model do
  it '広島幟町第10は橋本町510ビルの100メートル以内' do
    Park.create_nobori_10
    expect(Park.within_range(Place.billing_510,100).count).to eq(1)
  end

  it '広島幟町第10はシャレオ中央より100メートル以外' do
    Park.create_nobori_10
    expect(Park.within_range(Place.shakehands,100).count).to eq(0)
  end

  describe '#hour_fee' do
    subject { Park.new({fee: fee}).hour_fee }
    context "feeはtext" do
      let(:fee) { {type: 'text',text: ''} }
      it { should eq(nil) }
    end

    context "feeがbasic" do
      let(:fee) { {type: 'basic',per_minute: 30, fee: 200} }
      it { should eq(400) }
    end
  end

  describe '#calc_fee' do
    subject { Park.new({fee: fee}).calc_fee(time, time.since(3.hour)) }
    let(:time) { Time.zone.now }
    let(:fee) { {type: 'basic', per_minute: 30, fee: 300} }
    it { should eq(1800) }
  end
end
