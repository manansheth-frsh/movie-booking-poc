class AddUniqueIndexToShows < ActiveRecord::Migration[6.1]
  def change
    add_index :shows, [:theatre_id, :slot, :date], unique: true, name: 'unique_theatre_slot_date'
  end
end
