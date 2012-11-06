class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.references :line
      t.references :location
      t.string :time
      t.string :days
    end
    add_index :stops, :line_id
    add_index :stops, :location_id
  end
end
