class BookingsController < ApplicationController
  before_action :set_aircraft, only: [:new, :create]
  before_action :set_booking, only: [:confirm, :deny]

  def new
    @booking = Booking.new
    @bookings = Booking.all
  end

  def create
    dates = params[:dates].split(' to ')
    b_params = booking_params
    b_params[:start_date] = dates[0]
    b_params[:end_date] = dates[1]
    @booking = Booking.new(b_params)
    @booking.aircraft = @aircraft
    if @booking.save
      redirect_to user_path(current_user)
    else
      redirect_to aircraft_path(@aircraft), status: :unprocessable_entity
    end
  end

  def update
    raise
  end

  def confirm
    if current_user == @booking.aircraft.user
      @booking.pending = 'confirmed'
    end
    @booking.save
    redirect_to user_path(current_user)
  end

  def deny
    if current_user == @booking.aircraft.user
      @booking.pending = 'denied'
    end
    @booking.save
    redirect_to user_path(current_user)
  end

  private

  def booking_params
    params.require(:booking).permit(:dates, :pending, :total_price, :user_id)
  end

  def set_aircraft
    @aircraft = Aircraft.find(params[:aircraft_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
