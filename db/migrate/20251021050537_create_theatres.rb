class CreateTheatres < ActiveRecord::Migration[6.1]
  def change
    create_table :theatres do |t|
      t.string :name
      t.string :city
      t.integer :capacity

      t.timestamps
    end
  end
end
