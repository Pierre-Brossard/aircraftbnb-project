require "open-uri"

AIRCRAFT_NAMES = [
      'Airco DH.4A',
      ' Airco DH.9C',
      ' Airco DH.16',
      ' BAT F.K.26',
      '  Blériot-SPAD S.27',
      ' Curtiss Eagle',
      'Farman F.60 Goliath',
      'Grahame-White Charabanc',
]

AIRCRAFT_PATHS = [
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716988166/development/seeds/LAPD_Bell_206_Jetranger_p1gc5y.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716988159/development/seeds/plane_negy1b.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716988151/development/seeds/warplane_nsainz.webp",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716988109/development/seeds/fedexplane_fvsp3o.webp",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716901388/development/seeds/Cessna_172S_Skyhawk__G-JMKE___45077563364_eunhxl.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716901388/development/seeds/LAPD_Bell_206_Jetranger_nrusrk.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716901388/development/seeds/Airbus_A400M_Atlas__ZM400__-_ASCOT482_uwgoz2.jpg",
  "https://res.cloudinary.com/dlwesrqwb/image/upload/v1716894549/development/seeds/slfizlcluj3aodg0if0gc0hjgzfr.jpg"
]

LOCATIONS = ["Dallas/Fort Worth International Airport",
    "Orlando International Airport",
    "Washington Dulles International Airport",
    "Beijing Daxing International Airport",
    "George Bush Intercontinental Airport",
    "Shanghai Pudong International Airport",
    "Cairo International Airport",
    "Suvarnabhumi International Airport",]

DESCRIPTION= "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

Booking.delete_all
Aircraft.delete_all
User.delete_all

user = User.create!(name: 'John Doe', email: 'john@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')
user_bis = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')

(0..7).each do |index|
  new_aircraft = Aircraft.new(
    name: AIRCRAFT_NAMES[index],
    location: LOCATIONS[index],
    category: Aircraft::CATEGORIES.sample,
    description: DESCRIPTION,
    capacity: (50..3500).to_a.sample,
    range: (100..150_000).to_a.sample,
    state: Aircraft::STATES.sample,
    day_price: (1000..100_000).to_a.sample,
    user: [user, user_bis].sample,
    start: Date.new(2024, 05, 24),
    end: Date.new(2024, 05, 30),
  )
  new_aircraft.photo.attach(io: URI.open(AIRCRAFT_PATHS.sample), filename: 'aircraft_photo.png')
  new_aircraft.save!
end


buyer = User.create!(name: 'iamabuyer', email: 'buy@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')
aircraft = Aircraft.last

Booking.create!(
  pending: 'pending',
  start_date: Date.new(2024, 10, 10),
  end_date: Date.new(2024, 10, 20),
  total_price: aircraft.day_price * 10,
  aircraft: aircraft,
  user: buyer
)

aircraft = Aircraft.first

Booking.create!(
  pending: 'pending',
  start_date: Date.new(2024, 12, 10),
  end_date: Date.new(2024, 12, 20),
  total_price: aircraft.day_price * 10,
  aircraft: aircraft,
  user: buyer
)
