# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe FeeCalculator, :type => :model do
  let(:calculator) { FeeCalculator.new(attr) }
  describe '#hour_fee' do
    subject { calculator.hour_fee(datetime) }
    let(:datetime) { Time.zone.now }

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

    context '30分200円最大500円の時' do
      let(:attr) do
        {
         'type' => 'basic',
         'per_minute' => 30,
         'fee' => 200,
         'max' => 500,
        }
      end

      it { is_expected.to eq(400) }
    end

    context '20:00から8:00 まで60分200円 8:00から20:00 まで20分200円' do
      let(:attr) do
        {
         'type' => 'times',
         'times' => [
                     {
                      'type' => 'basic',
                      'start' => { 'hour' => 20, 'min' => 0 },
                      'end' => { 'hour' => 8, 'min' => 0 },
                      'per_minute' => 60,
                      'fee' => 200,
                     },
                     {
                      'type' => 'basic',
                      'start' => { 'hour' => 8, 'min' => 0 },
                      'end' => { 'hour' => 20, 'min' => 0 },
                      'per_minute' => 20,
                      'fee' => 200,
                     },
                    ],
        }
      end

      context '時刻は2時' do
        let(:datetime) { DateTime.new(2015,3,3,2,0) }
        it { is_expected.to eq(200) }
      end

      context '時刻は9時' do
        let(:datetime) { DateTime.new(2015,3,3,9,0) }
        it { is_expected.to eq(600) }
      end

      context '時刻は21時' do
        let(:datetime) { DateTime.new(2015,3,3,21,0) }
        it { is_expected.to eq(200) }
      end

      context '時刻は19時50分' do
        let(:datetime) { DateTime.new(2015,3,3,19,50) }
        it { is_expected.to eq(400) }
      end
    end
  end
end
