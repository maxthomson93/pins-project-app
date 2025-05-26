class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :title
      t.string :category
      t.float :longitude
      t.float :latitude
      t.string :address
      t.string :opening_hours

      t.timestamps
    end
  end
end
