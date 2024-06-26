class Aircraft < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  CATEGORIES = ['Planes', 'Helicopter', 'Zeppelin']
  STATES =['Used', 'Broken', 'Can fly', 'Perfect condition']
  CATEGORY_ICONS = {
    planes: '<i class="fa-solid fa-plane" style="color: #ffffff;"></i>',
    helicopter: '<i class="fa-solid fa-helicopter" style="color: #ffffff;"></i>',
    zeppelin: '<i class="fa-solid fa-cloud" style="color: #ffffff;"></i>'
  }

  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :location, presence: true
  validates :category, presence: true, inclusion: { in: Aircraft::CATEGORIES }
  validates :description, presence: true
  validates :state, presence: true, inclusion: { in:Aircraft::STATES }
  validates :capacity, presence: true
  validates :day_price, presence: true
  validates :range, presence: true
  validates :start, presence: true
  validates :end, presence: true

  # link to active record
  has_one_attached :photo

  # link ot searchBar
  searchkick
end
