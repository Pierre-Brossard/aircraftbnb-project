class BookingsController < ApplicationController
  before_action :set_aircraft, only: [:new, :create]
  before_action :set_bookingn, only: [:confirm, :deny, :destroy]

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
    params.require(:booking).permit(:start_date, :end_date, :pending, :total_price, :user_id)
  end

  def set_aircraft
    @aircraft = Aircraft.find(params[:aircraft_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
