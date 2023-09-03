class HomeController < ApplicationController
  def index
    @calculations = Calculation.all
  end
end
