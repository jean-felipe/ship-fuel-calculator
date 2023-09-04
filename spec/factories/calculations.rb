# frozen_string_literal: true

# == Schema Information
#
# Table name: calculations
#
#  id            :bigint           not null, primary key
#  directives    :jsonb
#  fuel_required :decimal(15, 4)
#  gravity       :decimal(15, 4)
#  mass          :decimal(15, 4)
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :calculation do
    calculation_type { Calculation::TYPES.sample }
    fuel_required { 0 }
    gravity { 9.807 }
    mass { 28_801 }
  end
end
