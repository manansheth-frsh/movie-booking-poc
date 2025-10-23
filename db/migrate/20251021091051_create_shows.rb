class CreateShows < ActiveRecord::Migration[6.1]
  def change
    create_table :shows do |t|
      t.integer :slot, null: false
      t.date :date, null: false
      t.integer :current_available_bookings, null: false
      t.references :movie, null: false, foreign_key: true
      t.references :theatre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
