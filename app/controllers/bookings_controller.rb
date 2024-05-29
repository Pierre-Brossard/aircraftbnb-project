class BookingsController < ApplicationController
  before_action :set_aircraft, only: [:new, :create]
  before_action :set_booking, only: [:]

  def new
    @booking = Booking.new
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.aircraft  = @aircraft
    if @booking.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    @booking.destroy
    redirect_to user_path(current_user), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :pending, :total_price, :user_id)
  end

  def set_aircraft
    @aircraft = Aircraft.find(params[:aircraft_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
