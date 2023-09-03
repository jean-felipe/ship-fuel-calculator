class CalculationsController < ApplicationController
  before_action :find_calculator, only: :show

  def create
    creator.execute

    respond_to do |format|
      if creator.errors.some?
        format.html { render :new, status: :unprocessable_entity }
      else
        format.html { redirect_to calculation_url(creator.calculation), notice: 'Calculation Done!' }
      end
    end
  end

  def show; end

  private

  def creator
    @creator ||= Calculations::Saver.new(calculations_params)
  end

  def calculations_params
    params.require(:calculation).permit(
      :title, :mass, :gravity, :calculation_type
    )
  end

  def find_calculator
    @calculation = Calculation.find(params[:id])
  end
end
