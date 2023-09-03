require 'rails_helper'

RSpec.describe Calculations::Saver do
  describe '#execute' do
    context 'when calculating launch' do
      let(:params) do
        {
          mass: 28_801,
          gravity: 9.807,
          title: 'foo test',
          calculation_type: 'launch'
        }
      end

      before do
        @service = described_class.new(params)
        @service.execute
      end

      it 'calculates launch' do
        expect(@service.calculation.fuel_required.to_i).to eq(19_772)
      end

      it 'creates a new object on the database' do
        calculation = Calculation.last

        expect(calculation.title).to eq('foo test')
        expect(calculation.fuel_required).to eq(19_772)
        expect(calculation.calculation_type).to eq('launch')
      end
    end

    context 'when calculating landing' do
      let(:params) do
        {
          mass: 28_801,
          gravity: 9.807,
          title: 'foo landing test',
          calculation_type: 'landing'
        }
      end

      before do
        @service = described_class.new(params)
        @service.execute
      end

      it 'calculates landing' do
        expect(@service.calculation.fuel_required.to_i).to eq(13_447)
      end

      it 'creates a new object on the database' do
        calculation = Calculation.last

        expect(calculation.title).to eq('foo landing test')
        expect(calculation.fuel_required).to eq(13_447)
        expect(calculation.calculation_type).to eq('landing')
      end
    end
  end
end
