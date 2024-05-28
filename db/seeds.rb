# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


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

User.destroy_all
Aircraft.destroy_all


user = User.new
user.name = 'Maria'
user.email = 'test@example.com'
user.encrypted_password = '#$taawktljasktlw4aaglj'
user.save!

user_bis = User.new
user_bis.name = 'Bobby'
user_bis.email = 'test2@example.com'
user_bis.encrypted_password = '#$taawktlPPPPtlw4aaglj'
user_bis.save!

8.times do
  Aircraft.create!(
    name: AIRCRAFT_NAMES.sample,
    category: Aircraft::CATEGORIES.sample,
    description: 'An empty description',
    capacity: (50..3500).sample,
    range: (100..150_000).sample,
    state: Aircraft::STATES.sample,
    day_price: (1000..100_000).sample
  )
en
