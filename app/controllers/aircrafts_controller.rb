class AircraftsController < ApplicationController
  def new
    @aircraft = Aircraft.new
  end

  def create
    @aircraft = Aircraft.new(aircraft_params)
    @aircraft
  end

  private

  def aircraft_params
    params.require(:aircraft).permit(:name, :category, :description)
  end
end
