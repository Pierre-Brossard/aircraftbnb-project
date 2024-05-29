class AddLocationToAircrafts < ActiveRecord::Migration[7.1]
  def change
    add_column :aircrafts, :location, :string
  end
end
