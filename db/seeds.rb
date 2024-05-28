# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
 require "open-uri"

AIRCRAFT_NAMES = [
      'Airco DH.4A',
   ' Airco DH.9C',
   ' Airco DH.16',
   ' BAT F.K.26',
  '  Blériot-SPAD S.27',
   ' Curtiss Eagle',
    'Farman F.50P',
    'Farman F.60 Goliath',
    'Grahame-White Charabanc',
    'Junkers F.13',
    'Nieuport-Delage NiD 30',
    'Potez SEA VII',
    'Sopwith Wallaby',
    'Westland Limousine'
]

AIRCRAFT_PATHS = [
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716901388/development/Cessna_172S_Skyhawk__G-JMKE___45077563364_eunhxl.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716901388/development/LAPD_Bell_206_Jetranger_nrusrk.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716901388/development/Airbus_A400M_Atlas__ZM400__-_ASCOT482_uwgoz2.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716894549/development/slfizlcluj3aodg0if0gc0hjgzfr.jpg"
]

Booking.delete_all
Aircraft.delete_all
User.delete_all


user = User.create!(name: 'John Doe', email: 'john@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')
user_bis = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')

AIRCRAFT_NAMES.each do |name|
  new_aircraft = Aircraft.new(
    name: name,
    category: Aircraft::CATEGORIES.sample,
    description: 'An empty description',
    capacity: (50..3500).to_a.sample,
    range: (100..150_000).to_a.sample,
    state: Aircraft::STATES.sample,
    day_price: (1000..100_000).to_a.sample,
    user: [user, user_bis].sample
  )
  new_aircraft.photo.attach(io: URI.open(AIRCRAFT_PATHS.sample), filename: 'aircraft_photo.png')
  new_aircraft.save!
end


buyer = User.create!(name: 'iamabuyer', email: 'buy@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')
aircraft = Aircraft.last

Booking.create!(
  pending: 'PENDING',
  start_date: Date.new(2024, 10, 10),
  end_date: Date.new(2024, 10, 20),
  total_price: aircraft.day_price * 10,
  aircraft: aircraft,
  user: buyer
)

aircraft = Aircraft.first

Booking.create!(
  pending: 'ACCEPTED',
  start_date: Date.new(2024, 12, 10),
  end_date: Date.new(2024, 12, 20),
  total_price: aircraft.day_price * 10,
  aircraft: aircraft,
  user: buyer
)
