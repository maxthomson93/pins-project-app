class AddGoogleFieldsToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :google_place_id, :string
    add_index :places, :google_place_id
    add_column :places, :photo_reference, :string
  end
end
