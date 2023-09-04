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
    @creator ||= Calculations::Saver.new(
      calculations_params
      .except(:first_gravity_launch, :second_gravity_launch, :first_gravity_landing, :second_gravity_landing)
      .merge(directive_params)
    )
  end

  def calculations_params
    params.require(:calculation).permit(
      :title, :mass, :first_gravity_launch, :second_gravity_launch,
      :first_gravity_landing, :second_gravity_landing
    )
  end

  def directive_params
    {
      directives: [
        [:launch, calculations_params[:first_gravity_launch]], [:land, calculations_params[:first_gravity_landing]],
        [:launch, calculations_params[:second_gravity_launch]], [:land, calculations_params[:second_gravity_landing]]
      ]
    }
  end

  def find_calculator
    @calc = Calculation.find(params[:id])
  end
end
