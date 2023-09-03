class CalculationsController < ApplicationController
  before_action :find_calculator, only: :show

  def new
    @calculation = Calculation.new
  end

  def create
    creator.execute

    respond_to do |format|
      if creator.errors
        format.html { redirect_to root_path, notice: 'An Error happened!'}
      else
        format.html { redirect_to root_path, notice: 'Calculation Done!' }
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
    @calc = Calculation.find(params[:id])
  end
end
