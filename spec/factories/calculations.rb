# frozen_string_literal: true

FactoryBot.define do
  factory :calculation do
    calculation_type { Calculation::TYPES.sample }
    fuel_required { 0 }
    gravity { 9.807 }
    mass { 28_801 }
  end
end
