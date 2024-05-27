class Aircraft < ApplicationRecord
  CATEGORIES = ['Planes', 'Helicopter', 'Zeppelin']
  STATES =['Used', 'Broken', 'Can fly', 'Perfect condition']
  belongs_to :user

  validates :name, uniqueness: true, presence: true
  validates :category, presence: true, inclusion: { in: Aircraft::CATEGORIES }
  validates :description, presence: true
  validates :state, presence: true, inclusion: { in:Aircraft::STATES }
  validates :capacity, presence: true
  validates :day_price, presence: true
  validates :range, presence: true
end
