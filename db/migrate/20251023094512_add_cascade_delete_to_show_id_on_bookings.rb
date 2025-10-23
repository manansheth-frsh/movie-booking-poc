class AddCascadeDeleteToShowIdOnBookings < ActiveRecord::Migration[6.1]
  def change
    # 1. Remove the existing foreign key constraint
    remove_foreign_key :bookings, :shows
    
    # 2. Add the foreign key back, explicitly setting on_delete: :cascade
    add_foreign_key :bookings, :shows, column: :show_id, on_delete: :cascade
  end
end