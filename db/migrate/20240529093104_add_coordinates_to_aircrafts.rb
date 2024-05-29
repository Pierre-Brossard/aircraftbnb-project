class AddCoordinatesToAircrafts < ActiveRecord::Migration[7.1]
  def change
    add_column :aircrafts, :latitude, :float
    add_column :aircrafts, :longitude, :float
  end
end
