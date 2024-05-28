class AircraftsController < ApplicationController
  def index
    @aircrafts = Aircraft.all
  end

  def show

  end

  def new
    @aircraft = Aircraft.new
  end

  def create
    @aircraft = Aircraft.new(aircraft_params)
    @aircraft.user = current_user
    if @aircraft.save
      redirect_to aircrafts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def aircraft_params
    params.require(:aircraft).permit(:name, :category, :description, :capacity, :range, :state, :day_price, :photo)
  end
end
