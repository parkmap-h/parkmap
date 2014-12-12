require 'rails_helper'

RSpec.describe Park, :type => :model do
  def billing_510
    Park.point(132.468539,34.393454)
  end

  def shakehands
    Park.point(132.458730,34.393917)
  end

  it '広島幟町第10は橋本町510ビルの100メートル以内' do
    Park.create_nobori_10
    expect(Park.within_range(billing_510,100).count).to eq(1)
  end

  it '広島幟町第10はシャレオ中央より100メートル以外' do
    Park.create_nobori_10
    expect(Park.within_range(shakehands,100).count).to eq(0)
  end
end
