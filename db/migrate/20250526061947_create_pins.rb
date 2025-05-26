class CreatePins < ActiveRecord::Migration[7.1]
  def change
    create_table :pins do |t|
      t.string :label
      t.references :place, null: false, foreign_key: true
      t.references :map, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
