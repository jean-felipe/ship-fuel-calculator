# frozen_string_literal: true

module Calculations
  class Saver
    attr_reader :calculation, :errors

    def initialize(params)
      @params = params
      @calculation = Calculation.new(@params.except(:directives))
    end

    def execute
      mass = @params[:mass].to_f
      directives = @params[:directives]

      fuel_weight = directives.map do |directive|
        type, gravity = directive
        fuel = calculate_total_fuel(mass, gravity.to_f, type)
        mass += fuel
        fuel
      end

      @calculation.update!(
        fuel_required: fuel_weight.sum.to_i,
        directives: { directives: }
      )
    rescue ActiveRecord::RecordInvalid => e
      @errors = e.record.errors.messages
    end

    private

    def calculate_total_fuel(mass, gravity, type)
      results = []

      while mass.positive?
        results << send("calculate_#{type}", mass, gravity)
        mass = send("calculate_#{type}", mass, gravity)
      end

      results = results.reject(&:negative?)
      results.sum.round(2)
    end

    def calculate_launch(mass, gravity)
      mass * gravity * 0.042 - 33
    end

    def calculate_land(mass, gravity)
      mass * gravity * 0.033 - 42
    end
  end
end
