class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
    end
    add_index :lines, :name, {:unique => true}
  end
end
