class AddCascadeRulesShows < ActiveRecord::Migration[6.1]
  def change
    # Remove existing foreign keys if they exist
    # remove_foreign_key :shows, :movies if foreign_key_exists?(:shows, :movies)
    # remove_foreign_key :shows, :theatres if foreign_key_exists?(:shows, :theatres)

    # # Add foreign keys with ON DELETE CASCADE
    # add_foreign_key :shows, :movies, on_delete: :cascade
    # add_foreign_key :shows, :theatres, on_delete: :cascade
  end
end
