# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calculations::Saver do
  describe '#execute' do
    context 'when calculating launch' do
      let(:params) do
        {
          mass: 28_801,
          gravity: 9.807,
          title: 'launch Earth, land Moon, launch Moon, land Earth',
          directives: [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]
        }
      end

      before do
        @service = described_class.new(params)
        @service.execute
      end

      it 'calculates launch' do
        expect(@service.calculation.fuel_required.to_i).to eq(51_968)
      end

      it 'creates a new object on the database' do
        calculation = Calculation.last

        expect(calculation.title).to eq('launch Earth, land Moon, launch Moon, land Earth')
        expect(calculation.fuel_required.to_i).to eq(51_968)
      end
    end

    context 'when calculating landing' do
      let(:params) do
        {
          mass: 14_606,
          gravity: 9.807,
          title: 'foo landing test',
          directives: [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]
        }
      end

      before do
        @service = described_class.new(params)
        @service.execute
      end

      it 'calculates landing' do
        expect(@service.calculation.fuel_required.to_i).to eq(33_495)
      end

      it 'creates a new object on the database' do
        calculation = Calculation.last

        expect(calculation.title).to eq('foo landing test')
        expect(calculation.fuel_required).to eq(33_495)
      end
    end
  end
end
