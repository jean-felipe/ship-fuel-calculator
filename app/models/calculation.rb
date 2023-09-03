# frozen_string_literal: true

# == Schema Information
#
# Table name: calculations
#
#  id               :bigint           not null, primary key
#  calculation_type :integer          default(0)
#  fuel_required    :decimal(15, 4)
#  gravity          :decimal(15, 4)
#  mass             :decimal(15, 4)
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Calculation < ApplicationRecord
  TYPES = %w[launch landing].freeze

  enum calculation_type: TYPES
end
