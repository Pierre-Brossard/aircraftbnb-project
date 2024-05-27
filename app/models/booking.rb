class Booking < ApplicationRecord
  belongs_to :aircraft
  belongs_to :user
end
