class AircraftsController < ApplicationController
  before_action :set_aircraft, only: %i[show destroy]

  def index
    @aircrafts = Aircraft.where('user_id != ?', current_user.id)

    @markers = @aircrafts.geocoded.map do |aircraft|
      {
        lat: aircraft.latitude,
        lng: aircraft.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {aircraft: aircraft}),
        marker_html: render_to_string(partial: "marker", locals: {aircraft: aircraft})
      }
    end
  end

  def show
  end

  def new
    @aircraft = Aircraft.new
  end

  def create
    availabilities = aircraft_params[:availabilities].split(' to ')
    air_params = aircraft_params
    air_params.delete(:availabilities)
    air_params[:start] = availabilities[0]
    air_params[:end] = availabilities[1]
    @aircraft = Aircraft.new(air_params)
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
    params.require(:aircraft).permit(:name, :location, :category, :description, :capacity, :range, :state, :day_price, :photo, :availabilities)
  end

  def set_aircraft
    @aircraft = Aircraft.find(params[:id])
  end
end
