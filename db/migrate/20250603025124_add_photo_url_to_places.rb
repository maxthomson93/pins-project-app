# db/migrate/20250603025124_add_photo_url_to_places.rb

class AddPhotoUrlToPlaces < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:places, :photo_url)
      add_column :places, :photo_url, :string
    end
  end
end
