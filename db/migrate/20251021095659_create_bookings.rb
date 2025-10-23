class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.integer :seats

      t.timestamps
    end
  end
end
