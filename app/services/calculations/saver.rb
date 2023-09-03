# frozen_string_literal: true

module Calculations
  class Saver
    attr_reader :calculation, :errors

    def initialize(params)
      @params = params
      @calculation = Calculation.new(@params)
    end

    def execute
      gravity = @params[:gravity]
      mass = @params[:mass]
      type = @params[:calculation_type]

      @calculation.fuel_required = calculate_total_fuel(mass, gravity, type)

      return if @calculation.save!

      @errors = @calculation.errors.messages
    end

    private

    def calculate_total_fuel(mass, gravity, type)
      results = []

      while mass.positive?
        results << send("calculate_#{type}", mass, gravity).to_i
        mass = send("calculate_#{type}", mass, gravity).to_i
      end

      results = results.reject(&:negative?)
      results.sum
    end

    def calculate_launch(mass, gravity)
      mass * gravity * 0.042 - 33
    end

    def calculate_landing(mass, gravity)
      mass * gravity * 0.033 - 42
    end
  end
end
