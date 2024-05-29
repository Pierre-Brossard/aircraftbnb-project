class AddAvailibilitiesToAircraft < ActiveRecord::Migration[7.1]
  def change
    add_column :aircrafts, :start, :date
    add_column :aircrafts, :end, :date
  end
end
