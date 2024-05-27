class CreateAircrafts < ActiveRecord::Migration[7.1]
  def change
    create_table :aircrafts do |t|
      t.string :name
      t.string :category
      t.text :description
      t.string :state
      t.integer :capacity
      t.integer :range
      t.decimal :day_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
