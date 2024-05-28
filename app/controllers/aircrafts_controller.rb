class AircraftsController < ApplicationController
  before_action :set_aircraft, only: %i[show destroy]

  def index
    @aircrafts = Aircraft.all
    @bookings = Booking.all
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

  def destroy
    @aircraft.destroy
    redirect_to aircrafts_path, status: :see_other
  end

  private

  def aircraft_params
    params.require(:aircraft).permit(:name, :category, :description, :capacity, :range, :state, :day_price, :photo)
  end

  def set_aircraft
    @aircraft = Aircraft.find(params[:id])
  end
end
