class RemovePinFromReviews < ActiveRecord::Migration[7.1]
  def change
    remove_reference :reviews, :pin, null: false, foreign_key: true
  end
end
