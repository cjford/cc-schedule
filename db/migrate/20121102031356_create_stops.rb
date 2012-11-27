class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.references :line
      t.references :location
      t.integer :hour
      t.integer :minute
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
    end
    add_index :stops, :line_id
    add_index :stops, :location_id
  end
end
