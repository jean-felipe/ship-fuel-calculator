class HomeController < ApplicationController
  def index
    @calculations = Calculation.all
    @calculation = Calculation.new
  end
end
