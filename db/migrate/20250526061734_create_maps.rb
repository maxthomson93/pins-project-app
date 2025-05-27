class CreateMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :maps do |t|
      t.string :name
      t.string :description
      t.integer :permission, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
